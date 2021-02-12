{include file="/admincp/header.tpl" nocache}
{$projects.cid = $projects.category_id}
{if $projects.id == ''} {$projects.id = 0} {/if}
<link rel="stylesheet" type="text/css" href="{$config['externalcss']}/jquery.datetimepicker.css" />
<div class="container-fluid">
    <!-- Page Heading -->
    <div class="row">
        <div class="col-lg-12" style="margin-top:2%;">
            <ol class="breadcrumb">
                <li class="active"> <i class="fa fa-edit"></i> {if $projects.id == 0 or $projects.id == ''} Add {else} Edit {/if} Product <i class="fa fa-angle-double-right"></i> {$projects.title} </li>
            </ol>
        </div>
    </div>
    <!-- /.row -->
    <div class="row">
        <div class="col-xs-12">
            {if $stat == 1}
                <div class="alert alert-success"> <strong>Saved!</strong> Product : {$projects.title} was successfully updated. </div>
            {/if}
            {if $error == 'saved'}
                <div class="alert alert-success"> <strong>Saved!</strong> {$users.first_name} profile was successfully changed. </div>
            {elseif $error != ''}
                <div class="alert alert-danger"> <strong>{$error}</strong> </div>
            {/if}
        </div>
        <div class="col-xs-12">
            <form method="POST" att-selected-cat='{$selected_cats}' enctype="multipart/form-data" class="admin_form form-horizontal" data-parsley-validate name="add-product" id="add-product" action="{$config.url}/admincp/products/save">
                <input type="hidden" value="{$projects.id}" name="id"/>
                <input type="hidden" name="sid" id="sid" value="{$sid}"/>
                <!-- <input type="hidden" name="last_url" id="last_url" value="{$last_url}"/> -->
                <!-- <input type="hidden" name="stax" id="stax" value="{$loged.stax_per}"> -->
                <div class="row">
                     <div class="col-md-12">
                        <div class="form-group">
                            <div class="col-sm-6">
                                Product ID : {$projects.pkey}<br>
                                Product type : {if $projects.auction == 0} Direct Buy Market{/if} {if $projects.auction == 1} Openbid Market {/if}<br>
                                {if $projects.auction == 1}
                                    Trading Type : {if $projects.trading_type == 'sell'} Sell {/if} {if $projects.trading_type == 'buy'} Buy {/if}
                                {/if}
                                <!-- <input  type="text" class="form-control" value="{$projects.pkey}" disabled> -->
                            </div>
                        </div>
                     </div>
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <div class="row">
                            <div class="col-sm-4">
                                Product Name
                                <input class="mt-5"  type="text" class="form-control" id="title" placeholder="Product Name" name="title" value="{$projects.title}" data-parsley-pattern="^[A-Za-z- ]*$" pattern="^[A-Za-z- ]*$" data-parsley-pattern-message="Invalid project title" data-parsley-required data-parsley-required-message="Please enter the product title" data-parsley-trigger="change">
                            </div>
                            {if $projects.auction == 0}
                            <div class="col-sm-4">
                                Brand Name
                                <input class="mt-5" type="text" class="form-control" id="brand" placeholder="Brand Name" name="brand" value="{$projects.brand}">
                            </div>
                            {/if}
                            {if $projects.auction == 1}
                            <div class="col-sm-4">
                                <div class="row">
                                    <div class="col-sm-12">
                                        <span class="description"><i>Trading type</i></span>
                                    </div>
                                    <div class="col-sm-12">
                                        <div class="radio-con">
                                            <div class="radio2">
                                                <input id="radio-3" name="trading_type" type="radio" value="sell" {if $projects.trading_type=='sell'} checked {/if}>
                                                <label for="radio-3" class="radio-label">sell</label>
                                            </div>
                                            <div class="radio2">
                                                <input id="radio-4" name="trading_type" type="radio" value="buy" {if $projects.trading_type=='buy'} checked {/if}>
                                                <label for="radio-4" class="radio-label">buy</label>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            {/if}
                        </div>
    <!--                     <div class="form-group">
                            <div class="col-sm-6">
                                <span class="description"><i>Product type</i></span>
                            </div>
                            <div class="col-sm-6">
                                <div class="radio-con">
                                    <div class="radio2">
                                        <input id="radio-1" name="auction" type="radio" value="1" {if $projects.auction==0} checked {/if}>
                                        <label for="radio-1" class="radio-label">Direct buy</label>
                                    </div>
                                    <div class="radio2">
                                        <input id="radio-2" name="auction" type="radio" value="0" {if $projects.auction==1} checked {/if}>
                                        <label for="radio-2" class="radio-label">Openbid</label>
                                    </div>
                                </div>
                            </div>
                        </div> -->


                        <div class="row mt-15">
													
													
                            <div class="col-md-12 padlr">
                              
                                <div class="col-sm-6">
                                    <div class="col-sm-12">
                                        <span class="description"><i>Is the product cannabis or cannabis-infused? </i></span>
                                    </div>
                                    <div class="col-sm-12">
                                        <div class="radio-con">
                                            <div class="radio2">
                                                <input id="radio-7" name="cannabis_type" type="radio" value="y" {if $projects.cannabis_type=='y'} checked {/if}>
                                                <label for="radio-7" class="radio-label">Yes</label>
                                            </div>
                                            <div class="radio2">
                                                <input id="radio-8" name="cannabis_type" type="radio" value="n" {if $projects.cannabis_type=='n'} checked {/if} {if $projects.id==0} checked {/if}>
                                                <label for="radio-8" class="radio-label">No</label>
                                            </div>
                                        </div>
                                    </div>
																	
                            <div class="testresult">
                                <div class="col-md-8 test-result">
                                   
                                    <div class="col-sm-12 mt-15" style="margin-right:0px;">
																			 <div class="pro-thumb grey-bg w100">
                                        {if $projects.cannabis_type=='y'}
                                        <img id="filec3" src="{$config.imgpath}testresult/{$projects.test_result}" class="img-responsive margin-auto" alt="">
                                        {/if}
                                        {if $projects.cannabis_type=='n'}
                                        <img id="filec3" src="{$config.url}/images/upload-img.png" class="img-responsive margin-auto" alt="">
                                        {/if}
                                        {if !$projects.cannabis_type}
                                        <img id="filec3" src="{$config.url}/images/upload-img.png" class="img-responsive margin-auto" alt="">
                                        {/if}
                                    </div>
                                        <span class="f12 m5"><i>Upload Test Result  (*.jpeg, *.jpg, *.png etc.)</i></span>
                                        <input name="test_results" type="file" onchange="canabis_image()" accept="image/*" id="filecount3" multiple="multiple" data-parsley-trigger="change" {if $projects.id==''} data-parsley-required-message="Please Upload Test Results" data-parsley-required {/if} {if $projects.id && ($projects.cannabis_type=='n' )} data-parsley-required data-parsley-required-message="Please upload test results" {/if} data-parsley-errors-container="#test_results-err">
                                    </div>
                                    <span id="test_results-err" class="err-message"></span>
                                </div>
                            </div>
                                </div>
															  {if $projects.auction == 0}
                                <div class="col-sm-6">
                                    <div class="col-sm-12">
                                        <span class="description"><i>Is the products price negotiable?</i></span>
                                    </div>
                                    <div class="col-sm-12">
                                        <div class="radio-con">
                                            <div class="radio2">
                                                <input id="radio-5" name="negotiable" type="radio" value="1" {if $projects.negotiable==1} checked {/if}>
                                                <label for="radio-5" class="radio-label">Yes</label>
                                            </div>
                                            <div class="radio2">
                                                <input id="radio-6" name="negotiable" type="radio" value="0" {if $projects.negotiable==0} checked {/if}>
                                                <label for="radio-6" class="radio-label">No</label>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-6 negotiable">
                                        <input style="width:48%;" class="p15 pb15 grey-bg border-0" type="text" data-parsley-trigger="change" placeholder="Suggested Price per Unit" id="sprice" name="sprice" value="{$projects.sprice}" data-parsley-required-message="Please Enter Suggested Price Per Unit" data-parsley-min-message="Please Enter Suggested Price Per Unit" data-parsley-type-message="Please Enter Suggested Price Per Unit" value="{$projects.sprice}" data-parsley-min="1" required>
                                    </div>
                                </div>
                                {/if}
                            </div>
													

                        </div>

                        <div class="row mt-15">
                            <div class="col-md-12 text-center">
                                <span class="description"><i class=""><b>How much product do you have to offer?</b></i></span>
                            </div>
                        </div>

                        <div class="row mt-15">
                            <div class="col-sm-4">
                                Price Per Unit
                                <input type="text" class="form-control mt-5" id="unit_price" placeholder="Price Per Unit" name="unit_price" data-parsley-type="number" data-parsley-type-message="Please enter price per unit" data-parsley-required data-parsley-required-message="Please enter price per unit" value="{$projects.unit_price}" data-parsley-min="1" data-parsley-trigger="change">
                            </div>
                            {if $projects.trading_type == 'sell'}
                            <div class="col-sm-4">
                                Sales Tax
                                <input class="w100 mt-5" type="number" name="stax" value="{$projects.stax}" disabled>
                            </div>
                            {/if}
                            {if $projects.auction == 1}
                        <div class="col-sm-4">
                               Order Type
                                <select class="mt-5"  name="order_type" data-parsley-required data-parsley-required-message="please select order type" data-parsley-trigger="change">
                                    <option value="">Order Type</option>
                                    <option value="total" {if $projects.order_type == 'total'} selected {/if} >Total Orders Only</option>
                                    <option value="partial" {if $projects.order_type == 'partial'} selected {/if} >Partial Orders Allowed</option>
                                </select>
                            </div>
                            {/if}
                        </div>
                        <div class="row mt-15">
                            <div class="col-sm-4">
                                Quantity Available
                                <input class="mt-5" type="text" class="form-control" id="qty" placeholder="Quantity Available" name="qty" data-parsley-required-message="Please add quantity" data-parsley-required data-parsley-min="1" data-parsley-min-message="Please enter quantity 1 or more" data-parsley-type="number" data-parsley-type-message="Please add quantity" value="{$projects.qty}" data-parsley-trigger="change">
                            </div>
                            <div class="col-sm-4">
                                Units
                                <select class="mt-5" name="units" id="units" data-parsley-required data-parsley-required-message="Please select units">
                                    <option value="">Units of Measure</option>
                                    <option value="ounces" {if $projects.units=='ounces'}selected {/if}>Ounces</option>
                                    <option value="pounds" {if $projects.units=='pounds'}selected {/if}>Pounds</option>
                                    <option value="grams" {if $projects.units=='grams'}selected {/if}>Grams</option>
                                    <option value="units" {if $projects.units=='units'}selected {/if}>Units</option>
                                </select>
                            </div>
                            <div class="col-sm-4">
                                Category
                                <select class="mt-5" id="loadcategory" data-parsley-trigger="change" name="parentcid" onchange="loadSubcategory(this)" data-parsley-required data-parsley-required-message="Please select category">
                                    <option class="black" value="">Select Category</option>
                                    {foreach $category as $key => $val}
                                    {if $projects.auction == 1}
                                     {if $val.parent_id == 0 && $val.ob_market==1}
                                    <option class="" value="{$val.id}" {if $projects.parent_category_id==$val.id} selected {/if}>{$val.name}
                                    </option>
                                    {/if}
                                    {/if}
                                    {if $projects.auction == 0}
                                     {if $val.parent_id == 0 && $val.db_market==1}
                                    <option class="" value="{$val.id}" {if $projects.parent_category_id==$val.id} selected {/if}>{$val.name}
                                    </option>
                                    {/if}
                                    {/if}

                                    {/foreach}
                                </select>
                            </div>
                        </div>
                        <div class="row mt-15">

                            <div class="col-sm-4">
                                Sub Category
                                <select class="mt-5" id="subcategories" name="cid" min="1" data-parsley-trigger="change" data-parsley-required data-parsley-required-message="Please select subcategory" data-parsley-min-message="Please select subcategory">
                                </select>
                            </div>
                        </div>
                        <div class="row mt-15">
                            <div class="col-sm-3">
                                <div class="pro-thumb grey-bg">
                                    {if $projects.avatar != ''}
                                    <img id="filec5" src="{$config.imgpath}product/{$projects.avatar}" class="img-responsive margin-auto" alt="">
                                    {/if}
                                    {if $projects.avatar == ''}
                                    <img id="filec5" src="{$config.url}/images/upload-img.png" class="img-responsive margin-auto" alt="">
                                    {/if}
                                    <!--  <img id="filec5" src="/images/upload-img.png" class="img-responsive margin-auto" alt=""> -->
                                </div>
                                <div class="flex">
                                    <div class="margin-auto">
                                        <span class="f12 m5"><i>Upload Item Images (*.jpeg, *.jpg, *.png etc.)</i></span>
                                        <input type="file" data-parsley-trigger="change" onchange="product_images()" id="filecount5" multiple="multiple" name="product_image" data-parsley-required-message="Please Upload Product Images" accept="image/*"
                                        {if $projects.id==0} data-parsley-required required {/if} data-parsley-errors-container="#product_image-err">
                                    </div>
                                </div>
                                <span id="product_image-err" class="err-message"></span>
                            </div>
                            <div class="col-sm-9">
                                <textarea class="grey-bg w100 border-0 p15 pb15" placeholder="Description" id="description" name="description" rows="9" cols="80" data-parsley-trigger="change" data-parsley-required data-parsley-required-message="Please enter description">{$projects.description}</textarea>
                            </div>
                        </div>
                        <div class="row flex">
                            <div class="col-sm-12 margin-auto text-right">
                                {if $projects.id > 0}
                                <button class="btn btn-default btn-d-b green-b" type="submit" class="btn btn-default">UPDATE</button>
                                {/if}
                                {if $projects.id == 0}
                                <button class="btn btn-default btn-d-b green-b btn_submit_final" type="submit" onclick="checkProductDetails()" class="btn btn-default">POST</button>
                                {/if}
                            </div>
                        </div>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>
{include file="/admincp/footer.tpl" nocache}
<script type="text/javascript" src="{$config.url}/js/jquery.datetimepicker.js"></script>
<script src="{$config['externaljs']}bootstrap-filestyle.min.js"></script>
<script type="text/javascript">
$("#start_date1").datetimepicker({
    // timepicker:false,
    format: 'm/d/Y H:m',
    step: 5,
    minDate: 0,
    minTime: 0
});
$("#start_date2").datetimepicker({
    // ttimepicker:false,
    format: 'm/d/Y H:m',
    step: 5,
    minDate: 0,
    minTime: 0
});

    $('#filecount5').filestyle({
     input : false,
     buttonName : 'btn btn-default btn-d-b btn-d-g m5 btbtxt',
     iconName : '',
     buttonText: 'UPLOAD'
    });



document.getElementById("filecount5").onchange = function() {

    if(projectLoad1(this)){

        document.getElementById("filec5").src = '';
        var reader = new FileReader();

        reader.onload = function(e) {
            // get loaded data and render thumbnail.
            document.getElementById("filec5").src = e.target.result;
        };
        $("#filecount5").parent().find('ul').hide();
        // read the image file as a data URL.
        reader.readAsDataURL(this.files[0]);
    } else {
        $(this).val('');
        $(this).parents().find(".badge").remove();
        document.getElementById("filec5").src = "{$config.url}/images/upload-img.png"
        // error message here
        // alert("not an image");
    }

};

    $('#filecount3').filestyle({
     input : false,
     buttonName : 'btn btn-default btn-d-b btn-d-g m5 w100',
     iconName : '',
     buttonText: 'UPLOAD'
    });

document.getElementById("filecount3").onchange = function() {

    if(projectLoad1(this)){
        
        document.getElementById("filec3").src = '';
        var reader = new FileReader();

        reader.onload = function(e) {
            // get loaded data and render thumbnail.
            document.getElementById("filec3").src = e.target.result;
        };
        $("#filecount3").parent().find('ul').hide();
        // read the image file as a data URL.
        reader.readAsDataURL(this.files[0]);
    } else {
        $(this).val('');
        $(this).parents().find(".badge").remove();
        document.getElementById("filec3").src = "{$config.url}/images/upload-img.png"
        // error message here
        // alert("not an image");
    }

};

/* subcategory and category dropdown */
{if $projects.parent_category_id}
$('#loadcategory').val({$projects.parent_category_id}).change();
{/if}

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

    $(function () {
        $('.testresult').hide();
        {if $projects.cannabis_type == 'y'}
            $('.testresult').show();
        {/if}
        $("input[name=cannabis_type]:radio").click(function () {
            if ($('input[name=cannabis_type]:checked').val() == "y") {
                $('.testresult').show();
                $('#filecount3').attr("required", true);
            } else if ($('input[name=cannabis_type]:checked').val() == "n") {
                $('.testresult').hide();
            }
        });
    });

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

    $(".alert").delay(4000).slideUp(200, function() {
    $(this).alert('close');
});
</script>
