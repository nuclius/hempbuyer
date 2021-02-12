{include file="/common/header-1.tpl" nocache}
{$projects.cid = $projects.category_id}
{if $projects.id == ''}
 {$projects.id = 0}
{/if}
<!-- <link rel="stylesheet" type="text/css" href="{$config['externalcss']}/jquery.datetimepicker.css" /> -->
<style>
#filec22, #filec2 {
  width: 150px;
  height: 150px;
  float: left;
}
#filec22:not(:last-child), #filec2:not(:last-child) {
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
<!-- page content  -->

    <div class="container-fluid store-fluid post-item-fluid grey-bg p0">
        <div class="page-caption m50">
        {if $projects.id > 0}
         <h1>Edit Your Item</h1>
        {/if}
        {if $projects.id == 0}
            <h1>post your item</h1>
          {/if}
        </div>
        <div class="row  m50"><div class="col-md-12 flex">
            <div class="col-lg-6 col-md-8 margin-auto white-bg-2 p35 shadow">


                        <form method="POST" att-selected-cat='{$selected_cats}' enctype="multipart/form-data" class="admin_form form-horizontal" data-parsley-validate name="add-product" id="add-product" action="{$config.url}/dashboard/storeproduct/save">
                            <input type="hidden" value="{$projects.id}" name="id" />
                            <input type="hidden" name="sid" id="sid" value="{$sid}" />
                            <input type="hidden" name="last_url" id="last_url" value="{$last_url}" />
                            <input type="hidden" name="stax" id="stax" value="{$loged.stax_per}">
                    <div class="row">
                        <div class="col-md-12">

                            <div class="form-group">
                              <div class="col-sm-6">
                                Product Name
                                <input class="w100 p15 pb15 grey-bg border-0" type="text" class="form-control" id="title" placeholder="Product Name" name="title"  value="{$projects.title}" data-parsley-required data-parsley-required-message="Please enter the product title" data-parsley-trigger="change" {if $projects.id>0}readonly{/if}>
                                <!-- data-parsley-pattern="^[A-Za-z- ]*$" pattern="^[A-Za-z- ]*$" data-parsley-pattern-message="Invalid project title"  -->
                              </div>
                              <div class="col-sm-6">
                                Brand Name
                                <input class="w100 p15 pb15 grey-bg border-0" type="text" class="form-control" id="brand" placeholder="Brand Name" name="brand"  value="{$projects.brand}" {if $projects.id>0}readonly{/if}>
                              </div>
                              <!-- <div class="col-sm-6">
                                <input class="w100 p15 pb15 grey-bg border-0" type="text" class="form-control" id="pwd" placeholder="Price Per Unit" name="unit_price" data-parsley-type="number" data-parsley-type-message="Please enter price per unit" data-parsley-required data-parsley-required-message="Please enter price per unit" value="{$projects.unit_price}" data-parsley-min="1">
                              </div> -->
                            </div>
                            <div class="form-group">
                              <div class="col-sm-6">
                                Metrc ID
                                <input class="w100 p15 pb15 grey-bg border-0" type="text" class="form-control" id="metrc_id" placeholder="METRC-ID" name="metrc_id"  value="{$projects.metrc_id}" {if $projects.id>0}readonly{/if}>
                              </div>
                              <div class="col-sm-6">
                                Brand SKU
                                <input class="w100 p15 pb15 grey-bg border-0" type="text" class="form-control" id="pkey" placeholder="Brand SKU" name="pkey"  value="{$projects.pkey}" {if $projects.id>0}readonly{/if}>
                              </div>
                            </div>

                            <div class="form-group">
                              <div class="col-sm-6">
                                <span class="description"><i>Allow cash on delivery</i></span>
                              </div>
                              <div class="col-sm-6">
                                  <div class="radio-con">
                                      <div class="radio2">
                                        <input id="radio-10" name="cod" type="radio" value="1" {if $projects.cod == 1} checked {/if}>
                                        <label for="{if $projects.id<1}radio-10{/if}" class="radio-label">Yes</label>
                                      </div>

                                      <div class="radio2">
                                        <input id="radio-11" name="cod" type="radio" value="0" {if $projects.cod == 0} checked {/if} {if $projects.id == 0} checked {/if}>
                                        <label  for="{if $projects.id<1}radio-11{/if}" class="radio-label">No</label>
                                      </div>
                                  </div>
                              </div>
                            </div>

                            <div class="form-group">
                              <div class="col-sm-6">
                                <span class="description"><i>Is the products price negotiable?</i></span>
                              </div>
                              <div class="col-sm-6">
                                  <div class="radio-con">
                                      <div class="radio2">
                                        <input id="radio-1" name="negotiable" type="radio" value="1" {if $projects.negotiable == 1} checked {/if}>
                                        <label for="{if $projects.id<1}radio-1{/if}" class="radio-label">Yes</label>
                                      </div>

                                      <div class="radio2">
                                        <input id="radio-2" name="negotiable" type="radio" value="0" {if $projects.negotiable == 0} checked {/if} {if $projects.id == 0} checked {/if}>
                                        <label  for="{if $projects.id<1}radio-2{/if}" class="radio-label">No</label>
                                      </div>
                                  </div>
                              </div>
                              <div class="col-md-12 negotiable">
                                <input style="width:48%;" class="p15 pb15 grey-bg border-0" type="text" data-parsley-trigger="change" placeholder="Suggested Price per Unit" id="sprice" name="sprice" value="{$projects.sprice}" data-parsley-required-message="Please Enter Suggested Price Per Unit"  data-parsley-min-message="Please Enter Suggested Price Per Unit"
                                        data-parsley-type-message="Please Enter Suggested Price Per Unit" value="{$projects.sprice}" data-parsley-min="1" required>
                              </div>
                            </div>


                            <div class="form-group">
                              <div class="col-sm-6">
                                <span class="description"><i>Is the product cannabis or cannabis-infused? </i></span>
                              </div>
                              <div class="col-sm-6">
                                  <div class="radio-con">
                                      <div class="radio2">
                                          <input id="radio-3" name="cinfuse" type="radio" value="y" {if $projects.cannabis_type == 'y'} checked {/if}>
                                          <label for="{if $projects.id<1}radio-3{/if}" class="radio-label">Yes</label>
                                        </div>

                                        <div class="radio2">
                                          <input id="radio-4" name="cinfuse" type="radio" value="n" {if $projects.cannabis_type == 'n'} checked {/if} {if $projects.id == 0} checked {/if}>
                                          <label  for="{if $projects.id<1}radio-4{/if}" class="radio-label">No</label>
                                       </div>
                                  </div>
                              </div>

                              <div class="col-md-12 testresult">
                                  Select the type of Test Result you are uploading above the menu
                                  <select class="w100 p15 pb15 grey-bg border-0" id="test_result_types" name="test_result_types" data-parsley-required-message="Please select test results" data-parsley-trigger="change">
                                      <option value="" selected>Select Test Result Type</option>
                                      <option value="analysis_certificate" {if $projects.test_result_types=='analysis_certificate'} selected {/if}>Certificate of Analysis</option>
                                      <option value="interim_testing" {if $projects.test_result_types=='interim_testing'} selected {/if}>Interim Testing</option>
                                      <option value="none" {if $projects.test_result_types=='none'} selected {/if}>No Test Results</option>
                                  </select>
                                  <br/>
                              </div>

                              <div class=" testresult">
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
                                          <span class="f12 m5"><i>Upload Test Result  (*.jpeg, *.jpg, *.png , *.pdf etc.)</i></span>
                                          <input name="test_results" type="file"  onchange="canabis_image()"  accept="image/*" id="filecount3" multiple="multiple"
                                           data-parsley-trigger="change" 

                                           
                                           
                                          data-parsley-errors-container="#test_results-err">
                                          <!-- {if $projects.id == ''} 
                                           data-parsley-required-message="Please Upload Test Results" data-parsley-required 
                                           {/if} 

                                           {if $projects.id && ($projects.cannabis_type == 'n')}  data-parsley-required 
                                           data-parsley-required-message="Please upload test results" 
                                           {/if} -->
                                      </div>
                                      <span id="test_results-err" class="err-message"></span>
                                  </div>
                              </div>

                               <div class="col-md-12 testresult2">
                                  <br>
                                  <div class="form-inline text-left">
                                      <label class="lab-clr">Do you need any testing services?</label>
                                        <div class="radio radio-inline radio-primary pt-0">
                                          <input data-parsley-trigger="change focudsout" type="radio" name="interim_testing_status" id="interim_testing_status1" value="y"  tabindex="8" {if $projects.interim_testing_status=='y'} checked="true" {/if}>
                                          <label for="{if $projects.id<1}interim_testing_status1{/if}"> Yes </label>
                                          <input data-parsley-trigger="change focusout" type="radio" name="interim_testing_status" id="interim_testing_status2" value="n" tabindex="9" {if $projects.interim_testing_status=='n'} checked="true" {/if}>
                                          <label for="{if $projects.id<1}interim_testing_status2{/if}"> No </label>
                                        </div>
                                  </div>
                              </div>
                              <div class="{if !$projects.interim_testing_status} hide {/if}{if $projects.interim_testing_status=='n'} hide {/if}" id="interim_testing_status_desc">
                                  <div class="col-sm-12 form-inline text-left">
                                      <label class="lab-clr"></label>
                                        <input type="text" class="w100 p15 pb15 grey-bg border-0" name="interim_testing_status_msg" value="{$projects.interim_testing_status_msg}" placeholder="Please enter the testing services you need and a Herbee Administrator will contact you shortly.">
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

                            <div class="form-group">
                              <div class="col-sm-4">
                                Price Per Unit
                                <input class="w100 p15 pb15 grey-bg border-0" type="text" class="form-control" id="unit_price" placeholder="Price Per Unit" name="unit_price" data-parsley-type="number" data-parsley-type-message="Please enter price per unit" data-parsley-required data-parsley-required-message="Please enter price per unit" value="{$projects.unit_price}" data-parsley-min="1" data-parsley-trigger="change">
                              </div>
                              {if $loged.business_type == "grower" || $loged.business_type == "producer"}
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

                              <div class="col-sm-4">
                                Sales Tax
                                  <input  class="w100 p15 pb15 grey-bg border-0" value="{$loged.stax_per}" disabled>
                              </div>
                            </div>

                            <div class="form-group">
                              <div class="col-sm-6">
                                Quantity Available
                                <input class="w100 p15 pb15 grey-bg border-0 onlynumber" type="text" class="form-control" id="qty" placeholder="Quantity Available" name="qty" data-parsley-required-message="Please add quantity" data-parsley-required data-parsley-min="1" data-parsley-min-message="Please enter quantity 1 or more"
                                        data-parsley-type="number" data-parsley-type-message="Please add quantity" value="{$projects.qty}" data-parsley-trigger="change" {if $projects.id>0}readonly{/if}>
                              </div>
                              <div class="col-sm-6">
                                Units
                                <select class="w100 p15 pb15 grey-bg border-0" name="units" id="units" data-parsley-required data-parsley-required-message="Please select units" {if $projects.id>0}disabled{/if}>
                                  <option value="">Units of Measure</option>
                                  <option value="ounces" {if $projects.units == 'ounces'}selected {/if}>Ounces</option>
                                  <option value="pounds" {if $projects.units == 'pounds'}selected {/if}>Pounds</option>
                                  <option value="grams" {if $projects.units == 'grams'}selected {/if}>Grams</option>
                                  <option value="units" {if $projects.units == 'units'}selected {/if}>Units</option>
                                </select>
                                {if $projects.id>0}<input type="hidden" name="units" value="{$projects.units}">{/if}
                              </div>
                            </div>

                            <div class="form-group">
                              <div class="col-sm-6">
                                  Category
                                  <select class="w100 p15 pb15 grey-bg border-0" id="loadcategory" data-parsley-trigger="change" name="categoryid" onchange="loadSubcategory(this)" data-parsley-required data-parsley-required-message="Please select category" {if $projects.id>0}disabled{/if}>
                                      <option class="black" value="">Select Category</option>
                                      {foreach $category as $key => $val}
                                          {if $val.parent_id == 0 && $val.db_market==1}
                                              <option class="" value="{$val.id}"
                                              {if $projects.parent_category_id == $val.id} selected {/if} >{$val.name}
                                              </option>
                                          {/if}
                                      {/foreach}
                                  </select>
                                  {if $projects.id>0}<input type="hidden" name="categoryid" value="{$projects.parent_category_id}">{/if}
                              </div>
                              <div class="col-sm-6">
                                  Sub Category
                                  <select class="w100 p15 pb15 grey-bg border-0" id="subcategories" name="subcategoryid" min="1" data-parsley-trigger="change" data-parsley-required data-parsley-required-message="Please select subcategory" data-parsley-min-message="Please select subcategory" {if $projects.id>0}disabled{/if}>
                                  </select>
                                  {if $projects.id>0}<input type="hidden" name="subcategoryid" value="{$projects.subcategory}">{/if}
                              </div>
                            </div>

                            <div class="form-group">
                              <div class="col-sm-12">
                                Product Notes
                                <textarea class="grey-bg w100 border-0 p15 pb15" placeholder="Description" id="descript" name="descript" rows="5" cols="80" data-parsley-trigger="change" data-parsley-required data-parsley-required-message="Please enter description">{$projects.description}</textarea>
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
                                    </div>
                                </div><span id="product_image-err" class="err-message"></span>
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
                                    <input type="text" class="w100 p15 pb15 grey-bg border-0" name="store_prdt_msg" value="{$projects.store_prdt_msg}" placeholder="Enter the service description">
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
                                        <input data-parsley-trigger="change focudsout" type="radio" name="default_distributor" id="default_distributor1" value="y"  tabindex="8" {if $projects.default_distributor=='y'} checked="true" {/if}>
                                        <label for="{if $projects.id<1}default_distributor1{/if}"> Yes </label>
                                        <input data-parsley-trigger="change focusout" type="radio" name="default_distributor" id="default_distributor2" value="n" tabindex="9"  {if $projects.default_distributor=='n'} checked="true" {/if}>
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
                                        <input data-parsley-trigger="change focudsout" type="radio" name="herbee_facility_status" id="herbee_facility_status1" value="y"  tabindex="8" {if $projects.herbee_facility_status=='y'} checked="true" {/if}>
                                        <label for="{if $projects.id<1}herbee_facility_status1{/if}"> Yes </label>
                                        <input data-parsley-trigger="change focusout" type="radio" name="herbee_facility_status" id="herbee_facility_status2" value="n" tabindex="9"  {if $projects.herbee_facility_status=='n'} checked="true" {/if}>
                                        <label for="{if $projects.id<1}herbee_facility_status2{/if}"> No </label>
                                      </div>
                                </div>
                            </div>
                            <div class="form-group" id="additional_service_status">
                                <div class="col-sm-12 form-inline text-left">
                                    <label class="lab-clr">Do you need any additional product-related services for your product (i.e. Manufacturing, Finishing Packaging, Sequencing, Labeling, etc.)?</label>
                                      <div class="radio radio-inline radio-primary ">
                                        <input data-parsley-trigger="change focudsout" type="radio" name="additional_service" id="additional_service1" value="y"  tabindex="8" {if $projects.additional_service=='y'} checked="true" {/if}>
                                        <label for="{if $projects.id<1}additional_service1{/if}"> Yes </label>
                                        <input data-parsley-trigger="change focusout" type="radio" name="additional_service" id="additional_service2" value="n" tabindex="9" {if $projects.additional_service=='n'} checked="true" {/if}>
                                        <label for="{if $projects.id<1}additional_service2{/if}"> No </label>
                                      </div>
                                </div>
                            </div>

                            <div class="form-group" id="additional_service_types">
                                <div class="col-sm-12 form-inline text-left">
                                    <label class="lab-clr"></label>
                                      <input type="text" class="w100 p15 pb15 grey-bg border-0" name="additional_service_type" value="{$projects.additional_service_type}" placeholder="Please describe the additional product-related services needed. A Herbee Administrator will contact you shortly.">
                                </div>
                            </div>
                         
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
                                <div class="col-sm-12 margin-auto text-right">
                                  {if $projects.id > 0}
                                   <button  class="btn btn-default btn-d-b green-b" type="submit" class="btn btn-default">UPDATE</button>
                                  {/if}
                                  {if $projects.id == 0}
                                   <button  class="btn btn-default btn-d-b green-b btn_submit_final" type="submit"  onclick="checkProductDetails()" class="btn btn-default">POST</button>
                                  {/if}
                                </div>
                              </div>
                        </div>
                    </div>
               </form>
            </div>
          </div>
        </div>
    </div>

<!-- / page content  -->
{include file="/common/footer-1.tpl" nocache}
<script type="text/javascript" src="{$config.url}/js/jquery.datetimepicker.js"></script>
<script type="text/javascript">


  $('input[name=store_prdt]').on('change', function(e) {
    if($(this).val() == 'y'){
        $("#store_prdt_desc").removeClass('hide');
    } else {
        $("#store_prdt_desc").addClass('hide');
    }
  });

  $('input[name=interim_testing_status]').on('change', function(e) {
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
    } else {
        $("#additional_service_types").addClass('hide');
    }
  });

    function checkProductDetails(){
        if(true === $('#add-product').parsley().isValid())
        {

            $('.btn_submit_final').attr("disabled", true);
            $('#add-product').submit();
        }else{
            return false;
        }
    }

if($('#loadcategory').val() == ''){
  $('#subcategories').html('');
        $('#subcategories').append( '<option value="0">Sub Category</option>' );
}

$(document).ready(function() {
    var catval = {$projects.parent_category_id}
    console.log('catval', catval);
    if(catval != undefined) {
        setTimeout(() => {
            $('#loadcategory').val().trigger('change');    
        }, 1000);
    }
});

 function loadSubcategory(cur) {
         $('#subcategories').html('');
        $('#subcategories').append( '<option value="0">Sub Category</option>' );
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
            $('#subcategories').append( '<option value="'+catsid+'" pid="'+pcid+'" {if $projects.category_id == "'+catsid+'"} selected {/if}>'+catname+'</option>' );
          }
        }
        $('#subcategories option[value="{$projects.category_id}"]').attr('selected','selected');


         }
      });
}
/* 
function product_images(){
  var ths = $("#filecount2");
      if(projectLoad1(ths)){
          document.getElementById("filec5").src = '';
          var reader = new FileReader();

          reader.onload = function(e) {
              document.getElementById("filec5").src = e.target.result;
          };
          $("#filecount2").parent().find('ul').hide();
          // read the image file as a data URL.
          reader.readAsDataURL($("#filecount2")[0].files[0]);
      } else {
          $(ths).val('');
          $(ths).parents().find(".badge").remove();
          document.getElementById("filec5").src = "{$config.url}/images/upload-img.png"
      }

} */

$(document).ready(function() {
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
            console.log('this.files', this.files);
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
});

function canabis_image(){
  var ths = $("#filecount3");
      if(projectLoad2(ths)){
          document.getElementById("filec4").src = '';
          var reader = new FileReader();
          reader.onload = function(e) {
            document.getElementById("filec4").src = e.target.result;
          };
          $("#filecount3").parent().find('ul').hide();
          // read the image file as a data URL.
          reader.readAsDataURL($("#filecount3")[0].files[0]);
          $('#filecount3').attr("required", true);
      } else {
          $(ths).val('');
          $(ths).parents().find(".badge").remove();
          document.getElementById("filec4").src = "{$config.url}/images/upload-img.png"
      }

}

  
</script>
<script>

$('#filecount6').filestyle({
    input: false,
    buttonName: 'btn btn-default btn-d-b btn-d-g m5 new_btn_text',
    iconName: '',
    buttonText: 'UPLOAD'
});

$(document).ready(function() {
    setTimeout(() => {
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
    }, 1000);
    
});


    $('#filecount2').filestyle({
     input : false,
     buttonName : 'btn btn-default btn-d-b btn-d-g m5 btbtxt new_btn_text',
     iconName : '',
     buttonText: 'UPLOAD'
    });

    $('#filecount3').filestyle({
     input : false,
     buttonName : 'btn btn-default btn-d-b btn-d-g m5 w100 new_btn_text',
     iconName : '',
     buttonText: 'UPLOAD'
    });

</script>
<script type="text/javascript">

  $(function () {

    if ($('input[name=additional_service]:checked').val() == "y") {
            $('#additional_service_types').show();
        } else $('#additional_service_types').hide();


    $("input[name=additional_service]:radio").click(function() {
        if ($('input[name=additional_service]:checked').val() == "y") {
            $('#additional_service_types').show();

        } else if ($('input[name=additional_service]:checked').val() == "n") {
            $('#additional_service_types').hide();
        }
    });

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



console.log($('select[name=test_result_types]').val());

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

    if ($('select[name=test_result_types]').val() == "none") {
            $('.testresult2').show();
        } else {
            $('.testresult2').hide();
    }

    $("select[name=test_result_types]").change(function() {
        console.log($('select[name=test_result_types]').val());
        if ($('select[name=test_result_types]').val() == "none") {
            $('.testresult2').show();
            $(".testresult").find('.test-result').hide();
        } else {
            $('.testresult2').hide();
            $(".testresult").find('.test-result').show();
        }
    });


        $('.testresult').hide();
        $('input[name=test_result_types]').attr('data-parsley-required','false');
        {if $projects.cannabis_type == 'y'}
          $('.testresult').show();
          $('input[name=test_result_types]').attr('data-parsley-required','true');
        {/if}

        $("input[name=cinfuse]:radio").click(function () {
          if ($('input[name=cinfuse]:checked').val() == "y") {
              $('.testresult').show();
              $('input[name=test_result_types]').attr('data-parsley-required','true');
              $('#filecount3').attr("required", true);
          } else if ($('input[name=cinfuse]:checked').val() == "n") {
              $('.testresult').hide();
              $('input[name=test_result_types]').attr('data-parsley-required','false');
          }
        });
    });
    </script>
<script language="javascript" type="text/javascript">
$('.negotiable').hide();
    $(function () {
        // $('.negotiable').hide();
        {if $projects.negotiable == '1'}
          $('.negotiable').show();
        {/if}
        {if $projects.negotiable == '0'}
          $('.negotiable').hide();
          $('.negotiable').find("input[name=sprice]").val(0);
        {/if}


        $("input[name=negotiable]:radio").click(function () {

        if ($('input[name=negotiable]:checked').val() == "1") {
            $('.negotiable').show();

        } else if ($('input[name=negotiable]:checked').val() == "0") {
                      $('.negotiable').find("input[name=sprice]").val(0);
            $('.negotiable').hide();

        }
        });
    });

$(document).ready(function () {

    $('.catselect').on('change', function() {
      var catid = this.value;
      $('.subcatid').html('');
       $('.subcatid').append( '<option value="0">Sub Category</option>' );
       $.ajax({
      type : 'POST',
       dataType : 'json',
      url : '/getchildcat',
      data : 'catid='+catid,
      success : function(data) {
         $('.subcatid').html('');
        $('.subcatid').append( '<option value="0">Sub Category</option>' );
        for (var i = 0; i < data.subcat.length; i++) {
            var catsid = data.subcat[i].id;
            var catname = data.subcat[i].name;
            $('.subcatid').append( '<option value="'+catsid+'">'+catname+'</option>' );
        }



         }
      });
    })

     {if $projects.cid > 0}

      $.ajax({
      type : 'POST',
       dataType : 'json',
      url : '/getchildcat',
      data : 'catid='+{$projects.parent_category_id},
      success : function(data) {
         $('.subcatid').html('');
        $('.subcatid').append( '<option value="0">Sub Category</option>' );
        for (var i = 0; i < data.subcat.length; i++) {
            var catsid = data.subcat[i].id;
            var catname = data.subcat[i].name;
            $('.subcatid').append( '<option value="'+catsid+'" {if $projects.category_id == "'+catsid+'"} selected {/if}>'+catname+'</option>' );
        }
        $('.subcatid option[value="{$projects.category_id}"]').attr('selected','selected');


         }
      });
    {/if}

});
$(function()
{
    var selected_cat_id = $('[att-selected-cat]').attr('att-selected-cat');
    if (selected_cat_id != '') {
        selected_cat_id = selected_cat_id.split(',');
        if(selected_cat_id.length > 0) {
            $('#product_category option').each(function() {
                if(selected_cat_id.indexOf($(this).val()) < 0) {
                    $(this).remove();
                }
            });
        }
    }
    /*Date.dayNames = ['Su', 'Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa'];
    Date.format = 'mm/dd/yyyy';
    $("#date_addeddd").datetimepicker({
    formatDate:'mm/dd/yyyy',
    minDate:'-1970/01/02'
  });
    $("#date_closeddd").datetimepicker({
    formatDate:'mm/dd/yyyy',
    minDate:'-1970/01/02'
  });*/


  var serverdate = '{$serverdate}';
d = servdate =  new Date(serverdate);
var logic = function( currentDateTime ){
  // 'this' is jquery object datetimepicker
  if( currentDateTime.getDate()==servdate.getDate() ){
    this.setOptions({
      minTime:addZero(servdate.getHours())+':'+addZero(servdate.getMinutes())
    });
  }else
    this.setOptions({
      minTime:'00:00'
    });
};
function addZero(i) {
    if (i < 10) {
        i = "0" + i;
    }
    return i;
}
var s = '{$projects.date_add}';
var pid = '{$projects.id}';
if(pid > 0)
d  = new Date(s);
/*else
s = d;*/
//alert(d.getHours());
jQuery('#date_addeddd').datetimepicker({
  // value: s,
  onChangeDateTime:logic,
  onShow:logic,
  format:'m/d/Y H:i:s',
  step:1,
 // mask:'9999/19/39 29:59',
 // value: new Date(s),
  //defaultSelect:true,
  defaultTime: addZero(d.getHours())+':'+addZero(d.getMinutes()),
  minTime:addZero(d.getHours())+':'+addZero(d.getMinutes()),
   minDate:  new Date(serverdate),//new Date()
});
var e = '{$projects.date_close}';
if(pid > 0)
d  = new Date(e);
/*else
s = d;*/
jQuery('#date_closeddd').datetimepicker({
  // value: e,
  onChangeDateTime:logic,
  onShow:logic,
  format:'m/d/Y H:i:s',
  step:1,
 // mask:'9999/19/39 29:59',
 // value: new Date(e),
  defaultTime: addZero(d.getHours())+':'+addZero(d.getMinutes()),
  minTime:addZero(d.getHours())+':'+addZero(d.getMinutes()),
   minDate:  new Date(serverdate),//new Date()
});
});
</script>
<script language="javascript" type="text/javascript">
function is_valid_url() {
  url = $("#documentvideourl").val();
  if(url != '') {
    var re = /(http(s)?:\\)?([\w-]+\.)+[\w-]+[.com|.in|.org]+(\[\?%&=]*)?/
    if (re.test(url)) {

    }
    else  {
      alert("Please enter valid URL");
      $("#documentvideourl").val("");
      $("#documentvideourl").focus();
      return false;
    }
  }
}




// Load Questionlist for subcategory

// Load Questionlist for category
/*function questionList()
{

 //console.log($('#pid').val());
 //console.log("/ajaxquestions/"+$('#product_category').val()+'/'+$('#pid').val());
   $.ajax({
  type: "GET",
  url: "/ajaxquestions/"+$('#product_category').val()+'/'+$('#pid').val(),
  success: function(data){
    $('.cquestions').removeClass('hide');
    if(data.length == 0)
        if($('#product_subcategory').val() !='') {
            qlist();

        }
      $('select[name="cid"] option[pid="'+$('#product_category').val()+'"]').show();
      $('.cquestions').addClass('hide');
    $('.category_questions').html(data);
  },

       complete: function(xhr, textStatus) {
           if(xhr.responseText == ''){
               $('.cquestions').addClass('hide');
           }
       }
   });
}*/
/*$(function(){
    {if $projects.id > 0}
        //questionList();
        if($('#product_subcategory').val() =='') {
            $('#product_subcategory').hide();
        }
     {/if}

});*/
$(function()
{

  {if !$projects.buynow}
   $('.buynow-area').hide();
  {/if}
  {if !$projects.vauction}
   $('.vauction-area').hide();
  {/if}
  {if $projects.time != ''}
   $('select[name="time"]').val('{$projects.time}').change();;
  {/if}
  {if $projects.time_level != ''}
   $('select[name="timelevel"]').val('{$projects.time_level}').change();;
  {/if}
  {if !$projects.auction}
   $('.auction-area').hide();
  {/if}
  {if $projects.shipping_price == 0}
   $('.free-shipping-area').hide();
  {/if}
   $('.shipping').on('click',function()
   {
      $('.shipping.disabled').removeClass('disabled');
      var att = $(this).attr('val');
      if(att == 1)
      {
        $('.free-shipping-area').hide();
        $('.free-shipping-area input').val(0.00);
      }
      else
      {
        $('.free-shipping-area').show();
        $('.free-shipping-area input').val('');
      }
      $(this).addClass('disabled');
   });
   $('.is_digital').on('click',function()
   {

      var att = $(this).attr('val');
      if(att == 1)
      {
        $('.is_digital_item').removeClass('hide');
      }
      else
      {
        $('.is_digital_item').addClass('hide');
      }
   });
   $('.location').on('click',function()
   {
      $('.location.disabled').removeClass('disabled');
      var m_loc =$(this).attr('val');
      if(m_loc == 1)
      {
        $('input[name="work_loc"]').val('');
      }
      else
      {
        $('input[name="work_loc"]').val($('input[name="work_loc"]').attr('default'));
      }
      $('input[name="is_location"]').val($(this).attr('val'));
      $(this).addClass('disabled');
   });
   $('.buynow').on('click',function()
   {
     if($(this).is(':checked'))
     {
           $('.buynow-area').show();
           $('.buynow-area input').attr('required',true);
           $('#bprice').attr('data-parsley-max',$('.buynow-area input[name="mprice"]').val());
         $('#buy_now').attr('data-parsley-max',$('.buynow-area input[name="mprice"]').val());

           $('.vauction-area').hide();
           $('.vauction').attr('checked',false).attr('disabled',true);
            $('.numberonly').attr('data-parsley-min','1');
         $('.numberonly').attr('data-parsley-min-message','Please enter valid quantity');
     }
     else
     {
           $('.buynow-area').hide();
           $('.buynow-area input').removeAttr('required');

		   $('.vauction').attr('checked',false).attr('disabled',false);
           $('#bprice').removeAttr('data-parsley-max');
         $('#buy_now').removeAttr('data-parsley-max');
         $('.numberonly').removeAttr('data-parsley-min');
         $('.numberonly').removeAttr('data-parsley-min-message');
     }
   });
   $('.auction').on('click',function()
   {
     if($(this).is(':checked'))
     {
           $('.auction-area').show();
           $('.auction-area input').attr('required',true);
           $('.buynow-area input[name="qty"]').val(1).attr('readonly',true);
           $('.vauction-area').hide();
           $('.vauction').attr('checked',false).attr('disabled',true);
		   $('#rprice').attr('data-parsley-min',$('.auction-area input[name="sprice"]').val());
     }
     else
     {
           $('.auction-area').hide();
           $('.auction-area input').removeAttr('required');
           $('.buynow-area input[name="qty"]').attr('readonly',false);
		   $('.vauction').attr('checked',false).attr('disabled',false);
           $('#rprice').removeAttr('data-parsley-min');
     }
   });
    $('.vauction').on('click',function()
   {
     if($(this).is(':checked'))
     {
           $('.vauction-area').show();
           $('.vauction-area input').attr('required',true);
           $('.buynow-area input[name="qty"]').val(1).attr('readonly',true);
		   $('.buynow').attr('checked',false).attr('disabled',true);
		   $('.auction-area').hide();
		   $('.buynow-area').hide();
           $('.auction').attr('checked',false).attr('disabled',true);
           $('#rprice').removeAttr('data-parsley-min');
     }
     else
     {
           $('.vauction-area').hide();
           $('.vauction-area input').removeAttr('required');
		   $('.auction').attr('checked',false).attr('disabled',false);
		   $('.buynow').attr('checked',false).attr('disabled',false);
           $('.buynow-area input[name="qty"]').attr('readonly',false);
           $('#rprice').removeAttr('data-parsley-min');
     }
   });
   /*$('#product_subcategory').on('change',function()
   {
      $('select[name="cid"] option').hide();
      $('select[name="cid"] option:first').show();
      $('select[name="cid"] option[selected]').removeAttr('selected');
      $('select[name="cid"] option[pid="'+$(this).val()+'"]').show();
     //console.log($(this).val());
      $('select[name="cid"] option[pid="'+$(this).val()+'"]:first').attr('selected',true);
   })*/

   Date.dayNames = ['Su', 'Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa'];
    Date.format = 'mm/dd/yyyy';
   {if $projects.id == '' || $projects.id == 0 || $projects.market_status == 'moderate' || $projects.market_status == 'draft'}
    $("#date_addedd").datePicker();
    $("#date_closedd").datePicker();
    {/if}
   $(function () {

            $("#uploadBtn").change(function () {
                $('#add-product').parsley().destroy();
                $('#disabled-select').removeAttr('required');
                $('#add-product').parsley();
                if (typeof (FileReader) != "undefined") {
                    var dvPreview = $("#dvPreview");
                    dvPreview.html("");
                    var regex = /^([a-zA-Z0-9\s_\\.\-:])+(.jpg|.jpeg|.gif|.png|.bmp)$/;
                    var count = 0;
                    var total_size = 0
                    $($(this)[0].files).each(function () {
                        var file = $(this);
                        total_size = total_size + file[0].size;
                        if (regex.test(file[0].name.toLowerCase())) {
                          count++;
                          var npreview = count;
                          var nadded = $("div.pro_image").length;
                          imgtoadd = npreview + nadded;

                            tot_count = parseInt($(".pro_image > img").size()) + count;

                              var reader = new FileReader();
                              reader.onload = function (e) {
                                  var img = $("<img />");
                                  img.attr("style", "height:100px;width: 100px");
                                  img.attr("src", e.target.result);

                                    dvPreview.append(img);

                              }
                              reader.readAsDataURL(file[0]);

                        } else {
                            alert(file[0].name + " is not a valid image file.");
                            dvPreview.html("");
                            return false;
                        }
                    });
					var  allowed_attach_limit = '{$loged.allowed_attach_limit}';
                    if(allowed_attach_limit != -1){

                        var total_used = 0;
                        $('input[name="save_draft"]').prop('disabled',false);
                        $('input[name="save"]').prop('disabled',false);
                        total_size = {$convertBytesToKb}(total_size);

                        var allowd_attach_limit = allowed_attach_limit * 1024;

                        total_used = {$sumFloat}(total_size,allowed_attach_limit);

                        if(parseFloat(total_used) > parseFloat(allowd_attach_limit)){
                            alert("Your attachment limit is exceed. Please update your plan");
                            $('input[name="save"]').prop('disabled',true);

                            $('input[name="save_draft"]').prop('disabled',true);

                        }

                    }

                } else {
                    alert("This browser does not support HTML5 FileReader.");
                }
                tot_count = parseInt($(".pro_image > img").size()) + count;
                $('#img_count').val(tot_count);
                if(tot_count >10){
                    $('#img_count').val(10);
                    alert("Images should be less than 10");
                }
            });

        });

});
     </script>
<script>
  /* document.getElementById("uploadBtn").onchange = function () {
   // document.getElementById("uploadFile").value = this.value;
};*/


   $('#date_closeddd').blur(function(){
       sdate = $('#date_addeddd').val();
       edate =  $('#date_closeddd').val();
       if(sdate != '') {
           if (new Date(sdate).getTime() > new Date(edate).getTime()) {
               alert("End date should not be lesser then start date");
           }
       }
   });
function shippingaction(tis)
{
  $('.shipoption').show();
  if($(tis).val() == 'Local pick up only'){
  $('.shipoption').hide();
  $('.free-shipping-area').hide();
      $('input[name="shipping_fee"]').val(0.00);
  }else{
      $('.free-shipping-area').show();
  }

}

if($('.shipping_description').val() == 'localpickup')
  $('.shipoption').hide();

function qlist()
{

 //console.log($('#pid').val());
 //console.log("/ajaxquestions/"+$('#cid').val()+'/'+parseInt($('#pid').val()));
   $.ajax({
  type: "GET",
  url: "{$config.url}/ajaxquestions/"+$('#cid').val()+'/'+parseInt($('#pid').val()),
  success: function(data){
    $('.cquestions').removeClass('hide');
    $('.cat').hide();
	console.log(data);
    if(data == '')
      $('.cquestions').addClass('hide');
    $('.category_questions').html(data);

  //$('.cattitle').append($('#catdynval').html());
  }
  });
}

function questionList()
{
 //console.log($('#pid').val());
   $.ajax({
  type: "GET",
  url: "/ajaxquestions/"+$('#product_category').val()+'/'+$('#pid').val(),
  success: function(data){
    $('.cquestions').removeClass('hide');
    if(data.length == 0)
      $('.cquestions').addClass('hide');
    $('.category_questions').html(data);


  }
  });
}
$(function(){
    {if $projects.cid > 0}
       //console.log('{$projects.cid}');
       // checkLevelSubCategory('{$projects.cid}',0);
        var ctry = '{$projects.sell_location}';
        $('#country').val(ctry);
    {/if}
    {if $projects.buynow == 0}
        $('#buy_now').removeAttr('data-parsley-max');
    {/if}
    {if $projects.shipping_description == 'Local pick up only'}
        $('.shipoption').hide();
        $('.free-shipping-area').hide();
    {/if}

    if($('#country').val() == '') {
        $('#country').val('USA');
    }

});

$( ".btn_submit" ).click(function(e) {

    e.preventDefault();

      CKupdate();
      if($('#description').val() !=''){
          $('#description').parsley().destroy();
      }
       /* tot_count = parseInt($(".pro_image > img").size()) + parseInt($("#dvPreview > img").size());
        if(tot_count > 10){
            alert("Images should be less than 10");
            return false;
        }*/
    var imagecnt = $('#fileuploader_iframe').contents().find('tbody.files tr.template-download').length;

    if(imagecnt > 10)
    {
        alert("Maximum Image Limit 10.");
        z = 0;
        return false;
    }
      if(false === $('#add-product').parsley().validate())
      {
          return false;
      }else{
          $('#finish').click();
          $('input:submit').attr("disabled", true);
      }
    });

                  $( "input[name='save_draft']" ).click(function(e) {

                      e.preventDefault();
                      CKupdate();
                      if($('#description').val() !=''){
                          $('#description').parsley().destroy();
                      }
                      tot_count = parseInt($(".pro_image > img").size()) + parseInt($("#dvPreview > img").size());
                      if(tot_count > 10){
                          alert("Images should be less than 10");
                          return false;
                      }
                      if(false === $('#add-product').parsley().validate())
                      {
                          return false;
                      }else{

                          $('#save_draft').click();
                          $('input:submit').attr("disabled", true);

                      }
                  });
$(function()
{
    $('#product_category').attr('parent-cid','');
    $('body').on('change','[parent-cid]', function () {
        $('#parentcid').attr('value',$(this).val());
    });
	$('.image-uploader img').each(function()
	{
		$(this).on('click',function(){
			//console.log(2);
	       $('input[type="file"]').click();
		});
	});
});
$('.onlynumber').bind("keypress", function (evt) {

        var theEvent = evt || window.event;
        var key1 = theEvent.keyCode || theEvent.which;
        var key = String.fromCharCode(key1);
        var regex = /[0-9]/;

     if( !regex.test(key) ) {
            if(key1 == 8 || key1 == 9 || key1 == 39){

            }else{
                theEvent.returnValue = false;
                if(theEvent.preventDefault) theEvent.preventDefault();
            }
        }
        else {
            if(key1 == 8 || key1 == 9 || key1 == 39){
                if(key == '.'){

                    theEvent.returnValue = false;
                    if(theEvent.preventDefault) theEvent.preventDefault();

                }
                else if(key == '%'){
                    if(theEvent.keyCode==37 && theEvent.charCode==0){ // Percentage has same code allowing left arrow

                    }else{
                        theEvent.returnValue = false;
                        if(theEvent.preventDefault) theEvent.preventDefault();
                    }

                }else if(key == "'"){
                    if(theEvent.keyCode==39 && theEvent.charCode==0){ // Single Quote

                    }else {
                        theEvent.returnValue = false;
                        if (theEvent.preventDefault) theEvent.preventDefault();
                    }
                }else{

                }
            }
            else{
                if( !regex.test(key) ) {
                    theEvent.returnValue = false;
                    if(theEvent.preventDefault) theEvent.preventDefault();
                }
                else {

                }
            }
        }
    }
);
</script>

<style>
.buynowprice ul {
  position: absolute;
  margin-top: 36px !important;
  margin-left: -32px!important;
  width: 348px;
}
.sub_level_category ul {
    display: none;
}
</style>
