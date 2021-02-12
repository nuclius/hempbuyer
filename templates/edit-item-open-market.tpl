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
{include file="common/dashboard-navigation.tpl" nocache}
<div class="container-fluid store-fluid post-item-fluid grey-bg p0">
    <div class="row  m50">
        <div class="col-md-12 flex">
        <div class="col-lg-6 col-md-8 margin-auto white-bg-2 p35 shadow">
            {if $updation_status}
            <div class="alert alert-success">
                <strong>Success!</strong> "{$projects.title}" updated successfully
            </div>
            {/if}
            <div class="row">
                <div class="col-md-12">
                    <ul class="nav nav-pills nav-justified m20 frxs-wd">
                        <li {if $projects.trading_type != 'sell'} class="active" {/if} ><a data-toggle="pill" href="#buy">BUY</a></li>
                        <li {if $projects.trading_type == 'sell'} class="active" {/if} ><a data-toggle="pill" href="#sell">SELL</a></li>
                    </ul>
                    <div class="tab-content">
                        <div id="buy" class="tab-pane fade {if $projects.trading_type != 'sell'}active in{/if}">
                            {if !$projects.id}
                            <form method="POST" att-selected-cat='{$selected_cats}' enctype="multipart/form-data" class="form-horizontal" data-parsley-validate name="add-product" id="add-product" action="{$config.url}/product/openbid/save">
                                {/if} 
                                {if $projects.id}
                                <form method="POST" att-selected-cat='{$selected_cats}' enctype="multipart/form-data" class="form-horizontal" data-parsley-validate name="add-product" id="add-product" action="{$config.url}/dashboard/openbid/product/save">
                                {/if}

                                    <input type="hidden" name="currency_type" id="currency_type" value="{$currencytype}">
                                    <input type="hidden" name="id" id="product_id" value="{$projects.id}">
                                    <input type="hidden" id="trading_type" name="trading_type" value="buy">
                                    <div class="form-group">
                                        <div class="col-sm-6">
                                            <input class="w100 p15 pb15 grey-bg border-0" type="text" class="form-control" id="project_title" placeholder="Product Name" name="title" value="{$projects.title}" data-parsley-required data-parsley-required-message="Please enter the Product title">
                                        </div>
                                        <div class="col-sm-6">
                                            <!-- <input class="w100 p15 pb15 grey-bg border-0" type="text" class="form-control" id="target_price" data-parsley-type="number" data-parsley-type-message="please enter the target price" data-parsley-required data-parsley-required-message="Please enter the target price" placeholder="Target Price" name="target_price"> -->
                                            <input class="w100 p15 pb15 grey-bg border-0" type="text" class="form-control" id="target_price" data-parsley-type="number" data-parsley-type-message="please enter the target price" min="1" data-parsley-required data-parsley-required-message="Please enter the target price" placeholder="Target Price" name="target_price" value="{$projects.sprice}">
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
                                    <!--
                                    <div class="form-group">
                                      <div class="col-sm-6">
                                        <span class="description"><i>Is the product cannabis or cannabis-infused? </i></span>
                                      </div>
                                      <div class="col-sm-6">
                                          <div class="radio-con">
                                              <div class="radio2">
                                                  <input id="radio-3" name="radio" type="radio" value="test">
                                                  <label for="radio-3" class="radio-label">Yes</label>
                                                </div>

                                                <div class="radio2">
                                                  <input id="radio-4" name="radio" type="radio" value="testdisable" checked>
                                                  <label  for="radio-4" class="radio-label">No</label>
                                               </div>
                                          </div>
                                      </div>

                                          <div class="col-md-12 testresult">
                                              <div class="pro-thumb grey-bg flex w100">
                                                <img src="{$config.url}/images/upload-img.png" class="img-responsive margin-auto" alt="">
                                              </div>
                                              <div class="margin-auto" style="margin-right:0px;">
                                                  <span class="f12 m5"><i>Upload Test Result</i></span>
                                                  <input name="test-result-name" type="file" id="filecount3" multiple="multiple" value="test">
                                              </div>
                                          </div>

                                    </div> -->
                                    <div class="form-group">
                                        <div class="row">
                                            <div class="col-md-12 text-center">
                                                <span class="description"><i class="">How much product would you like to request?</i></span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <div class="col-sm-6">
                                            <input class="w100 p15 pb15 grey-bg border-0" type="text" class="form-control" id="qty" placeholder="Available Quantity" name="qty" data-parsley-required-message="Please add quantity" data-parsley-required data-parsley-min="1" data-parsley-min-message="Please enter quantity 1 or more" data-parsley-type="number" data-parsley-type-message="please enter the quantity number" value="{$projects.qty}">
                                        </div>
                                        <div class="col-sm-6">
                                            <select class="w100 p15 pb15 grey-bg border-0" id="units" name="units" data-parsley-required data-parsley-required-message="Please select units">
                                                <option value="" selected>Units of Measure</option>
                                                <option value="ounces" {if $projects.units=='ounces'} selected {/if}>Ounces</option>
                                                <option value="pounds" {if $projects.units=='pounds'} selected {/if}>Pounds</option>
                                                <option value="grams" {if $projects.units=='grams'} selected {/if}>Grams</option>
                                                <option value="units" {if $projects.units=='units'} selected {/if}>Units</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <div class="col-sm-6">
                                            <select class="w100 p15 pb15 grey-bg border-0" name="category" onchange="loadSubcategory(this)" data-parsley-required data-parsley-required-message="Please select category">
                                                <option class="black" value="">Select Category</option>
                                                {foreach $category as $key => $val} 
                                                    {if $val.parent_id == 0}
                                                        <option class="black" value="{$val.id}" 
                                                        {if $projects.parent_category_id == $val.id} selected {/if} >{$val.name}
                                                        </option>
                                                    {/if} 
                                                {/foreach}
                                            </select>
                                        </div>
                                        <div class="col-sm-6">
                                            <select class="w100 p15 pb15 grey-bg border-0" id="subcategories" name="subcategory" data-parsley-required data-parsley-required-message="Please select subcategory">
                                                <option value="">Sub Category</option>
                                                {foreach $category as $key => $val} 
                                                {if $val.parent_id != 0}
                                                <option hidden value="{$val.id}" pid="{$val.parent_id}" {if $projects.category_id == $val.id} selected {/if} >
                                                    {$val.name}</option>
                                                {/if} 
                                                {/foreach}
                                            </select>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <div class="col-sm-6">
                                            <div class="inner-addon right-addon">
                                                <i class="glyphicon glyphicon-calendar"></i>
                                                <input class="w100 p15 pb15 grey-bg border-0" type="text" id="start_date1" placeholder="Date Requested" name="start_date" data-parsley-required data-parsley-required-message="Please select date" value="{$projects.date_add}">
                                            </div>
                                        </div>
                                        <div class="col-sm-6">
                                            <select class="w100 p15 pb15 grey-bg border-0" name="order_type" data-parsley-required data-parsley-required-message="please select order type">
                                                <option value="">Order Type</option>
                                                <option value="total" {if $projects.order_type == 'total'} selected {/if} >Total Orders Only</option>
                                                <option value="partial" {if $projects.order_type == 'partial'} selected {/if} >Partial Orders Allowed</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <div class="col-sm-3">
                                            <div class="pro-thumb grey-bg flex">
                                                <img id="filec2" src="{$config.url}/images/upload-img.png" class="img-responsive margin-auto" alt="">
                                            </div>
                                            <div class="flex">
                                                <div class="margin-auto">
                                                    <span class="f12 m5"><i>Upload Item Images (*.jpeg, *.jpg, *.png etc.)</i></span>
                                                    <input type="file" id="filecount2" name="product_image" multiple="multiple" accept="image/*" data-parsley-required data-parsley-required-message="Please select images">
                                                    <!--                                                 <input type="file" id="filecount2" name="product_image" multiple="multiple"> -->
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-sm-9">
                                            <textarea class="grey-bg w100 border-0 p15 pb15" placeholder="Description" name="description" data-parsley-required data-parsley-required-message="description is required" rows="9" cols="80">{$projects.description}</textarea>
                                        </div>
                                    </div>
                                    <div class="row flex">
                                        <div class="col-sm-12 margin-auto text-right">
                                            <button class="btn btn-default btn-d-b green-b" type="submit" class="btn btn-default">POST</button>
                                        </div>
                                    </div>
                                </form>
                        </div>
                        <!-- Buy Close -->
                        <div id="sell" class="tab-pane fade {if $projects.trading_type == 'sell'}active in{/if}">
                            <!-- <form class="form-horizontal" action="/action_page.php"> -->
                            <!-- <form method="POST" enctype="multipart/form-data" class="form-horizontal" data-parsley-validate name="add-obproduct" id="add-obproduct" action="{$config.url}/product/openbid/save"> -->
                            {if !$projects.id}
                            <form method="POST" att-selected-cat='{$selected_cats}' enctype="multipart/form-data" class="form-horizontal" data-parsley-validate name="add-product" id="add-product" action="{$config.url}/product/openbid/save">
                                {/if} {if $projects.id}
                                <form method="POST" att-selected-cat='{$selected_cats}' enctype="multipart/form-data" class="form-horizontal" data-parsley-validate name="add-product" id="add-product" action="{$config.url}/dashboard/openbid/product/save">
                                    {/if}
                                    <input type="hidden" id="sell_product" name="trading_type" value="sell">
                                    <input type="hidden" name="currency_type" id="currency_type" value="{$currencytype}">
                                    <input type="hidden" name="id" id="currency_type" value="{$projects.id}">
                                    <div class="form-group">
                                        <div class="col-sm-6">
                                            <input class="w100 p15 pb15 grey-bg border-0" type="text" class="form-control" id="project_title" placeholder="Product Name" name="title" value="{$projects.title}" data-parsley-required data-parsley-required-message="Please enter the Product title">
                                        </div>
                                        <div class="col-sm-6">
                                            <input class="w100 p15 pb15 grey-bg border-0" type="text" class="form-control" id="target_price" data-parsley-type="number" data-parsley-type-message="please enter the target price" data-parsley-required data-parsley-required-message="Please enter the target price" min="1" placeholder="Target Price" name="target_price" value="{$projects.sprice}">
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
                                                    <label for="radio-5" class="radio-label">Yes</label>
                                                </div>
                                                <div class="radio2">
                                                    <input id="radio-6" name="cannabis_type" type="radio" value="n" {if $projects.cannabis_type != 'y'} checked {/if}>
                                                    <label for="radio-6" class="radio-label">No</label>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-12 testresult">
                                            <div class="pro-thumb grey-bg flex w100">
                                                <img id="filec4" src="{$config.url}/images/upload-img.png" class="img-responsive margin-auto" alt="">
                                            </div>
                                            <div class="margin-auto" style="margin-right:0px;">
                                                <span class="f12 m5"><i>Upload Test Result</i></span>
                                                <input type="file" id="filecount4" name="test_results" data-parsley-required data-parsley-required-message="Please upload test results" multiple="multiple" required/>
                                                <!--  <input name="test-result-name" type="file" id="filecount4" multiple="multiple" value="test"> -->
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
                                            <input class="w100 p15 pb15 grey-bg border-0" type="text" class="form-control" id="qty" placeholder="Available Quantity" name="qty" data-parsley-required-message="Please add quantity" data-parsley-required data-parsley-min="1" data-parsley-min-message="Please enter quantity 1 or more" data-parsley-type="number" data-parsley-type-message="please enter the quantity number" value="{$projects.qty}">
                                        </div>
                                        <div class="col-sm-4">
                                            <input class="w100 p15 pb15 grey-bg border-0" type="text" class="form-control" id="qty" placeholder="Sales tax(%)" name="stax" data-parsley-required-message="Please Enter sales tax" data-parsley-required data-parsley-min="1" data-parsley-min-message="Please enter sales tax percentage 1 or more" data-parsley-type="number" data-parsley-type-message="please enter the quantity number" value="{$projects.stax}">
                                        </div>
                                        <div class="col-sm-4">
                                            <select class="w100 p15 pb15 grey-bg border-0" id="units" name="units" data-parsley-required data-parsley-required-message="Please select units">
                                                <option value="" selected>Units of Measure</option>
                                                <option value="ounces" {if $projects.units=='ounces'} selected {/if}>Ounces</option>
                                                <option value="pounds" {if $projects.units=='pounds'} selected {/if}>Pounds</option>
                                                <option value="grams" {if $projects.units=='grams'} selected {/if}>Grams</option>
                                                <option value="units" {if $projects.units=='units'} selected {/if}>Units</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <div class="col-sm-6">
                                            <select class="w100 p15 pb15 grey-bg border-0" name="category" onchange="loadSubcategory(this)" r data-parsley-required data-parsley-required-message="Please select category">
                                                <option class="black" value="">Select Category</option>
                                                {foreach $category as $key => $val} 
                                                    {if $val.parent_id == 0}
                                                    <!-- <option class="black" value="{$val.id}">{$val.name}</option> -->
                                                        <option class="black" value="{$val.id}" {if $projects.parent_category_id == $val.id} selected {/if}>{$val.name}
                                                        </option>
                                                    {/if} 
                                                {/foreach}
                                            </select>
                                        </div>
                                        <div class="col-sm-6">
                                            <select class="w100 p15 pb15 grey-bg border-0" id="subcategories" name="subcategory" data-parsley-required data-parsley-required-message="Please select subcategory">
                                                <option value="">Sub Category</option>
                                                {foreach $category as $key => $val} 
                                                    {if $val.parent_id != 0}
                                                    <option hidden value="{$val.id}" pid="{$val.parent_id}" {if $projects.category_id == $val.id} selected {/if}>{$val.name}</option>
                                                    {/if} 
                                                {/foreach}
                                            </select>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <div class="col-sm-6">
                                            <div class="inner-addon right-addon">
                                                <i class="glyphicon glyphicon-calendar"></i>
                                                <!--                                             <input class="w100 p15 pb15 grey-bg border-0" type="text" id="start_date" placeholder="Date Available" name="start_date"> -->
                                                <input class="w100 p15 pb15 grey-bg border-0" type="text" id="start_date2" placeholder="Date Available" name="start_date" data-parsley-required data-parsley-required-message="Please select date" value="{$projects.date_add}">
                                            </div>
                                        </div>
                                        <div class="col-sm-6">
                                            <select class="w100 p15 pb15 grey-bg border-0" name="order_type" data-parsley-required data-parsley-required-message="Please select order type">
                                                <option value="">Order Type</option>
                                                <option value="total" {if $projects.order_type=='total'} selected {/if} >Total Orders Only</option>
                                                <option value="partial" {if $projects.order_type=='partial'} selected {/if} >Partial Orders Allowed</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <div class="col-sm-3">
                                            <div class="pro-thumb grey-bg flex">
                                                <img id="filec5" src="{$config.url}/images/upload-img.png" class="img-responsive margin-auto" alt="">
                                                <!-- <img id="filec5" src="{$config.url}/images/upload-img.png" class="img-responsive margin-auto" alt=""> -->
                                            </div>
                                            <div class="flex">
                                                <div class="margin-auto">
                                                    <span class="f12 m5"><i>Upload Item Images (*.jpeg, *.jpg, *.png etc.)</i></span>
                                                    <input type="file" id="filecount5" name="product_image" accept="image/*" data-parsley-required-message="Please upload product images" multiple="multiple" required/>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-sm-9">
                                            <textarea class="grey-bg w100 border-0 p15 pb15" placeholder="Description" name="description" data-parsley-required data-parsley-required-message="description is required" rows="9" cols="80">{$projects.description}</textarea>
                                        </div>
                                    </div>
                                    <div class="row flex">
                                        <div class="col-sm-12 margin-auto text-right">
                                            <button class="btn btn-default btn-d-b green-b" type="submit" class="btn btn-default">POST</button>
                                        </div>
                                    </div>
                                </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
                </div>
    </div>
</div>
<!-- / page content  -->
{include file="/common/footer-1.tpl" nocache}
<!-- <script type="text/javascript" src="{$config.url}/js/jquery.datetimepicker.js"></script> -->
<!-- loading subcategory -->
<script type="text/javascript">
function loadSubcategory(cur) {
   //console.log("subcategory");
    $('#subcategories option').hide();
    $('#subcategories').val("");
    $('#subcategories option[pid="' + $(cur).val() + '"]').show();
}
</script>
<script type="text/javascript">
/* jquery datepicker - Date available */

$("#start_date1").datetimepicker({
    // timepicker:false,
    // format:'d/m/Y',
    step: 5,
    minDate: 0,
    minTime: 0
});
$("#start_date2").datetimepicker({
    // ttimepicker:false,
    // format:'d/m/Y',
    step: 5,
    minDate: 0,
    minTime: 0
});
// $("#start_date2").datetimepicker({minDate:'0'});

$(function() {
    $('.testresult').hide();
    $("input[name=cannabis_type]:radio").click(function() {
        if ($('input[name=cannabis_type]:checked').val() == "y") {
            $('.testresult').show();

        } else if ($('input[name=cannabis_type]:checked').val() == "n") {
            $('.testresult').hide();
        }
    });
    // alert($("#mydatepickertime").length);
});
</script>
<script>
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
<script>
document.getElementById("filecount4").onchange = function() {
    var reader = new FileReader();

    reader.onload = function(e) {
        // get loaded data and render thumbnail.
        document.getElementById("filec4").src = e.target.result;
    };
    $("#filecount4").parent().find('ul').hide();
    // read the image file as a data URL.
    reader.readAsDataURL(this.files[0]);
};
</script>
<script>
document.getElementById("filecount5").onchange = function() {
    var reader = new FileReader();

    reader.onload = function(e) {
        // get loaded data and render thumbnail.
        document.getElementById("filec5").src = e.target.result;
    };
    $("#filecount5").parent().find('ul').hide();
    // read the image file as a data URL.
    reader.readAsDataURL(this.files[0]);
};
</script>
<script>
document.getElementById("filecount2").onchange = function() {
    var reader = new FileReader();

    reader.onload = function(e) {
        // get loaded data and render thumbnail.
        document.getElementById("filec2").src = e.target.result;
    };
    $("#filecount2").parent().find('ul').hide();
    // read the image file as a data URL.
    reader.readAsDataURL(this.files[0]);
};
</script>
</body>

</html>