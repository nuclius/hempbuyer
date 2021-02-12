{include file="/common/header-1.tpl" nocache}

<style>
     #productDocumentList .image-item {
            font-size: 30px;
            text-align: center;
            cursor: pointer;
            object-fit:cover;
            font-family: Geneva,Arial,Helvetica,sans-serif;
            border: 1px solid gray;
            width:110px;
            height: 110px;
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
            margin: 2px 20px;
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
        .removeProductDocument{
            margin-left: -3px; 
            color: white; 
            font-size: 12px;
            cursor: pointer;
            margin-top: 0;
            width: 148px;
            padding: 0;
            background: red; 
            padding: 11px;
            padding-right: 32px;
            top: -61px;
            border-right: 1px solid gray;
            border-bottom: 1px solid gray;
            padding-left: 31px;
            padding-top: 11px;
            border-left: 1px solid gray;
        }
    .pp-form {
        max-width: 841px; 
        margin: 0 auto 30px;
    } 
    
    @media(max-width:767px) {
        .pp-form {
            padding:25px 15px;
        }
    }
</style>
<div class="dashboard-container">
    {include file="/common/header-2.tpl" nocache}

    {* <div class="db-gray-box">
        <div class="container">
            <ol class="breadcrumb">
                <li><a href="#">Home</a></li>
                <li><a href="#"><i class="fa fa-angle-right"></i></a></li>
                <li class="active">Classifieds</li>
            </ol>
            <ul class="list-inline">
                <li class="list-inline-item">
                    <a href="">AUCTION</a>
                </li>
                <li class="list-inline-item">
                    <a href="">PROFILE</a>
                </li>
                <li class="list-inline-item">
                    <a href="">INBOX</a>
                </li>
                <li class="list-inline-item">
                    <a class="btn btn-pp" href="">
                        POST YOUR PRODUCT
                    </a>
                </li>
            </ul>
        </div>
    </div> *}
    <div class="container">
        <h3 class="ppf-title">Post Your Classifieds</h3>
        <form class="pp-form bg-gray" id="classifiedForm" name="classifiedForm" action="{$config.url}/classified/add" method="POST"  data-parsley-validate novalidate>
            <div class="ppic-wrap">
                <img src="/no_user_image.png" class="pp-img" alt="" /> 
            </div>
            <div class="row">
                <div class="col-12 form-group">
                    <label class="sf-label">Company Name</label>
                    <div class="icon-input">
                        <div class="icon-box">
                            <img src="{$config.url}/images/company.png" alt="" />
                        </div>
                        <input class="form-control" placeholder="Company Name" name="name" required data-parsley-trigger="change" />
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-12 form-group">
                    <label class="sf-label">Classified Title</label>
                    <div class="icon-input">
                        <div class="icon-box">
                            <img src="{$config.url}/images/company.png" alt="" />
                        </div>
                        <input class="form-control" placeholder="Enter your classified title" name="title" required data-parsley-trigger="change" />
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-sm-12 form-group">
                    <label class="sf-label">Category</label>
                    <div class="clearfix cselec-wrap">
                        <select class="custom-select loc-selc" style="height: 48px;" name="category" id="category" required data-parsley-trigger="change">
                            <option value="">Select Category</option>
                            {foreach $categoryList as $key => $val}
                                <option value="{$val.value}">{$val.text}</option>
                            {/foreach}
                        </select>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-12 form-group">
                    <label class="pp-label">Short Description</label>
                    <textarea rows="2" class="form-control"
                        placeholder="Enter Short Description of your classified" name="short_description" required style="height: auto;" data-parsley-trigger="change"></textarea>
                </div>
            </div>
            <div class="row">
                <div class="col-12 form-group">
                    <label class="pp-label">Description</label>
                    <textarea rows="4" class="form-control"
                        placeholder="Enter Description of your classified" name="description" required data-parsley-trigger="change"></textarea>
                </div>
            </div>
            <div class="row">
                <div class="col-12 form-group">
                    <label class="sf-label">Company Website URL</label>
                    <div class="icon-input">
                        <div class="icon-box">
                            <img src="{$config.url}/images/cs-img.png" alt="" class="globe-img" />
                        </div>
                        <input class="form-control" placeholder="Enter your company website url" name="website" id="website" required type="url" data-parsley-trigger="change" />
                    </div>
                    <div id="urlError" style="color:red; display:none;">Url is invalid. Please enter like <i>https://www.xyz.com</i></div>
                </div>
            </div>
            <div class="row">
                <div class="col-12 form-group">
                    <label class="btn btn-brown float-left" for="companyLogo" title="Upload size of 250 X 200">UPLOAD COMPANY LOGO</label>
                    <input type="file" id="companyLogo" name="companyLogo" style="display: none;" onchange="editBannerFileupload(this);" accept=".png, .jpeg, .jpg, .pdf">
                    <div style="display: inline-block; margin-left: 10px;">
                        <div class="text-secondary">Upload size of 250 X 200</div>
                        <a id="companylogo_name_div" target="_blank" href=""></a>
                        <div style="color: red; display: none" id="logoErr">This value is required.</div>
                    </div>
                </div>
            </div>
            <div class="form-group">
                <label class="pp-label">
                    Upload Images (jpeg, png)
                </label>
                <div class="upload-document">
                    <input type="file" class="form-control" name="upload-cimg" onchange="editClassifiedFileupload(this)" multiple>
                    <div>Upload size of 250 X 200</div>
                    <div>UPLOAD CLASSIFIED IMAGES (max 4 images)</div>
                    <button class="btn btn-primary">
                        UPLOAD IMAGE
                    </button>
                    <label style="color: red; display: none" id="imageErr">This value is required.</label>

                </div>

                <div id="productDocumentList" class="pro-img-list">
                    {if $product.productImages.length > 0}
                        {foreach $product.productImages as $key => $val}
                            <div class="image-item isNew" id="proddoc_{$key+1}"><img src="{$config.url}/uploads/product/{$val.avatar}" alt="No Image Available" onerror="this.onerror=null;this.src='/no_image.png';" style="margin:0px;width:100px; height:100px"> <a data-name="{$val.avatar}" href="javascript:void(0)" class="removeProductDocument">Remove</a></div>
                        {/foreach}
                    {/if}
                </div>
            </div>
            <div class="row">
                <div class="col-12 form-group">
                    <label class="sf-label">Email</label>
                    <div class="icon-input">
                        <div class="icon-box">
                            <img src="{$config.url}/images/email.png" alt="" />
                        </div>
                        <input class="form-control" placeholder="Enter your contact email id" name="email" required data-parsley-trigger="change"/>
                    </div>
                </div>
            </div>
            <div class="row"> 
                <div class="col-sm-6">
                    <div class="form-group">
                        <label class="sf-label">City:</label>
                        <div class="icon-input">
                            <div class="icon-box">
                                <img src="{$config.url}/images/marker.png" alt="" />
                            </div>
                            <input class="form-control" data-parsley-trigger="change focusout" placeholder="Enter City" value="{$users.city}" name="city" id="city" required>
                        </div>
                    </div>
                </div>
                <div class="col-sm-6 form-group">
                    <label class="sf-label">State</label>
                    <div class="clearfix cselec-wrap">
                        <select class="custom-select loc-selc" style="height: 48px;" name="state" id="state_abbr" required data-parsley-trigger="change">
                            <option value="">Select State</option>
                            {foreach $stateList as $key => $val}
                                <option value="{$val.abbrev}">{$val.name}</option>
                            {/foreach}
                        </select>
                    </div>
                </div>

            </div> 
            <div class="form-group clearfix" style="display: none;">
                <div class="cus-check float-left">
                    <input type="checkbox" name="is_special" id="is_special" />
                    <span class="checkmark"></span> <label for="is_special">Hempbuyer Special Promo Listing</label>
                </div>
            </div>
            <!-- <input name="images" hidden> -->
            <div class="pp-btns-wrap">
                <button class="btn btn-primary">SUBMIT</button>
            </div>
        </form>
    </div>
</div>


<script>
    productDocument = [];
    var config_url = '{$config.url}';

    function createProductDHtml(cer) {
        if(cer.length > 0)
                $('#pError').hide();

        for (let index = 0; index < cer.length; index++) {
            const element = cer[index];
            console.log('element', element);
            if(element) {
                var isImage = element.mimetype.split('/')[0];
                element.fileType = isImage;
                productDocument.push(element);
                $('#imageErr').hide();
                var total = $("#productDocumentList").find('.image-item').length;
                var link = base_url+'/uploads/classified/'+element.name;
                if(element.extension.toString().toLowerCase() == 'jpeg' || element.extension.toString().toLowerCase() == 'jpg' || element.extension.toString().toLowerCase() == 'png'){
                var html = '<div class="image-item isNew" id="proddoc_'+(total+1)+'"><img src="'+link+'" alt="pImg" style="margin:0px;width:100px; height:100px"> <a data-name="'+element.name+'" href="javascript:void(0)" class="removeProductDocument">Remove</a></div>';
                }else{
                    var html = '<div class="image-item isNew" id="proddoc_'+(total+1)+'">  <video src="'+link+'" alt="pImg" style="margin:0px;width:100px; height:100px"></video>  <a data-name="'+element.name+'" href="javascript:void(0)" class="removeProductDocument">Remove</a></div>';
                }
                $("#productDocumentList").append(html);
            }
        }
    }


      /* Start Product Document of Analysis */
    function editClassifiedFileupload(obj)
    {
        var files = $('input[name="upload-cimg"]')[0].files;
        if((productDocument.length + files.length) > 4) {
            alert('You can upload maximum 4 images');
            return true;
        }
        var formData = new FormData();
        var fileSizeCount = 0;
        for (let index = 0; index < files.length; index++) {
            if(files[index].size < 5242880) {
                const element = files[index];
                formData.append('classified', element);
            } else
                fileSizeCount++;
        }
        $("#productDocumentLoader").show();
        var cntfle = $('input[name="upload-cimg"]')[0].files.length;
        if(fileSizeCount > 0) {
            alert('Max file size found from your selection. Please select minimum 5MB files.');
        } else {
            $.ajax({
                url : '/classified/addImage/'+cntfle,
                type : 'POST',
                xhr: function() {
                    var myXhr = $.ajaxSettings.xhr();
                    return myXhr; 
                },
                data : formData,
                processData: false,
                contentType: false,
                success : function(response) {

                    console.log(response);

                    if(response.document.length) {
                        createProductDHtml(response.document);
                        $('#pError').hide();
                    }
                    //console.log('response', response.productDocument);
                    // $("#loading_images").hide();
                    $('input[name="upload-cimg"]').val('');
                },
                error: function(e)
                {
                    //console.log(e);
                    $('input[name="upload-cimg"]').val('');
                },
            }).done(function() {
                $("#productDocumentLoader").hide();
            });
        }
    }
    /* End Product Document of Analysis */

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
                url: '/classified/deleteImage',
                data: { name: name, document_id: document_id },
                dataType: 'JSON',
                cache: false,
                success: function (data) {

                }
            });
            productDocument.splice(index, 1);

            if(productDocument.length<=0){
                $('#imageErr').show();
            }
            // localStorage.removeItem('drafedData');
            // storeLocalData(4);
        }
    });


        $(document).on('change', '#website', function() {
            $("#urlError").hide();
        });
        $(document).on('change', '#companyLogo', function() {
            $('#logoErr').hide();
        });


        $(document).on('submit', '#classifiedForm', function (e) {
            e.preventDefault();
            
            var url = $("#website").val();
            $("#urlError").hide();
            if(/^(https?|s?ftp):\/\/(((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:)*@)?(((\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])\.(\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])\.(\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])\.(\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5]))|((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.?)(:\d*)?)(\/((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)+(\/(([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)*)*)?)?(\?((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)|[\uE000-\uF8FF]|\/|\?)*)?(#((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)|\/|\?)*)?$/i.test(url) == false) {
                $("#urlError").show();
                $("#website").focus();
                return true;
            }

            $('#logoErr').hide();
            if($("#companyLogo")[0].files.length <=0){
                $('#logoErr').show();
                return;
            }
            if(productDocument.length <=0){
                $('#imageErr').show();
                return;
            }
            
            
            var form = $(this);
            form = form.serializeArray();
            console.log(form);

            var filenames = productDocument.map(x => x.name);

            form.push( { name :'images', value : filenames.toString() } );
            form.push( { name: 'company_logo', value : classified } );
            console.log(form)
            $.ajax({
                    method: "POST",
                    url: '{$config.url}/classified/add',
                    data: form,
                    dataType: 'JSON',
                    cache: false,
                    success: function (data) {
                        swal({ title: "SUCCESS", text: "Please wait for admin approval" }, function(){
                            window.location.href = '/classified';
                        });
                        // window.location.replace("/classified");
                    },error: function(data){
                        alert('Sorry Try Again!')
                    }
                });
                
        });

    /* Start Upload company logo */
    var classified = '';
    function editBannerFileupload(obj)
    {
        var files = $('input[name="companyLogo"]')[0].files;
        var formData = new FormData();
        for (let index = 0; index < files.length; index++) {
            const element = files[index];
            formData.append('classified', element);
        }
        $("#companyLogoLoader").show();
        var cntfle = $('input[name="companyLogo"]')[0].files.length;
        $.ajax({
            url : '/postcompanylogo/'+cntfle,
            type : 'POST',
            xhr: function() {
                var myXhr = $.ajaxSettings.xhr();
                return myXhr;
            },
            data : formData,
            processData: false,
            contentType: false,
            success : function(response) {
                if(response.classified.length) {
                    // createBannerHtml(response.classified);
                    classified = response.classified[0].name;
                    $("#companylogo_name_div").html(classified);
                    $("#companylogo_name_div").attr('href', config_url+'/uploads/classified/'+classified);
                }
                // $("#loading_images").hide();
            },
            error: function(e)
            {
                console.log(e);
            },
        }).done(function() {
            $("#companyLogoLoader").hide();
        });
    }
    /* End Upload company logo */
     
</script>
{include file="/common/footer-1.tpl" nocache}