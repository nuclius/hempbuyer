{include file="/common/header-1.tpl" nocache} 
<!-- <div class="clearfix auth-container" style="padding-top: 100px !important;"> -->
<section class="db-wrapper db-iwrap">
    {include file="/common/header-2.tpl" nocache}
    <div class="container">
        <div class="row">
            <div class="col-sm-6">
                <h3 class="acc-head">
                    ADVERTISEMENT
                </h3>
            </div> 
        </div>
        <div>
            <a class="btn advertise_btn {if $activePage=='advertisement'}active{/if}" href="/advertisement" style="line-height: 17px;">
                Create Advertisement
            </a>
            <a class="btn advertise_btn {if $activePage=='advertisements'}active{/if}" href="/advertisements" style="line-height: 17px;">
                Ads List
            </a>
        </div>
         <div class="db-content">
            <div class="db-right-con">
                <form id="create_ads_form" action="{$config.url}/buyer/activeAuction" method="post" class="pp-form bg-gray" style="border: 0 none;" data-parsley-validate novalidate>
                    <div class="row">
                        <div class="col-md-1 form-group">
                        </div>
                        <div class="col-md-10 form-group">
                            <div class="row">
                                <div class="col-sm-6 form-group">
                                    <label class="pp-label">Ad Name*</label>
                                    <div class="clearfix">
                                        <input class="form-control" placeholder="Ad Name" name="ad_name" id="ad_name" required data-parsley-required-message="Ad Name is required." value="{$product.ad_name}" />
                                    </div>
                                </div>
                                <div class="col-sm-6 form-group">
                                    <label class="pp-label">Ad Title</label>
                                    <div class="clearfix">
                                        <input class="form-control" placeholder="Ad Title" name="ad_title" id="ad_title" required data-parsley-required-message="Ad Title is required." value="{$product.ad_title}" />
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-sm-6 form-group">
                                    <label class="pp-label">Ad Content</label>
                                    <div class="clearfix">
                                        <input class="form-control" placeholder="Ad Content" name="ad_content" id="ad_content" value="{$product.ad_content}" />
                                    </div>
                                </div>
                                <div class="col-sm-6 form-group">
                                    <label class="pp-label">Ad URL*</label>
                                    <div class="clearfix">
                                        <input type="url" class="form-control" placeholder="Ad URL" name="ad_url" id="ad_url" required data-parsley-required-message="Ad URL is required." value="{$product.ad_url}" data-parsley-type="url" data-parsley-urlstrict />
                                    </div>
                                    <div id="urlError" style="color:red; display:none;">Url is invalid. Please enter like <i>https://www.xyz.com</i></div>
                                </div>
                            </div>
                            
                            <div class="row">
                                <div class="col-sm-6 form-group">
                                    <label class="btn btn-brown" for="bannerDocument" title="Upload size of 250 X 200">UPLOAD BANNER</label>
                                    <span class="text-secondary ul-size">Upload size of 250 X 200</span>
                                    <input type="file" id="bannerDocument" name="bannerDocument" style="display: none;" onchange="editBannerFileupload(this);" accept=".png, .jpeg, .jpg, .pdf">
                                    <a id="banners_name_div" target="_blank" href=""></a>
                                    <div id="iError" style="color:red; display:none;">Ad image is required.</div>
                                </div>
                                <div class="col-sm-6 form-group">
                                    <div>
                                        <div class="radio">
                                            <input type="radio" name="add_type" id="ad_continuously" value="1" {if $product.add_type=='1'}checked{/if} required data-parsley-errors-container="#errorType">
                                            <label for="ad_continuously" class="pp-label">CONTINUOUSLY</label>
                                        </div>
                                        <div class="radio">
                                            <input type="radio" name="add_type" id="ad_specific_date" value="2" {if $product.add_type=='2'}checked{/if} required>
                                            <label for="ad_specific_date" class="pp-label">UNTIL A SPECIFIC DATE</label>
                                        </div>
                                    </div>
                                    <div id="errorType" class="parsley-errors-list float-left"></div>
                                </div>
                            </div>

                            <div class="row" id="specific_date_div" style="display: none;">
                                <div class="col-sm-6 form-group">
                                    
                                </div>
                                <div class="col-sm-6 form-group">
                                    <div class="clearfix">
                                        <input class="form-control" placeholder="Specific Date" name="ad_end_date" id="ad_end_date" required data-parsley-required-message="Select specific is required." value="{$product.ad_end_date}" readonly data-parsley-trigger="change" />
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-12 form-group">
                                    <label class="pp-label">Targeting Sections* </label>
                                    <div class="clearfix">
                                        <div class="cus-check form-group1 suply2">
                                            <input type="checkbox" class="targeting" name="ad_home" id="ad_home" value="home" {if $product.target_sec_id[1]=='home'}checked{/if} data-parsley-mincheck="1" data-parsley-errors-container="#errorTargeting">
                                            <span class="checkmark"></span> <label for="ad_sunday">Homepage</label>
                                        </div>
                                        <div class="cus-check form-group1 suply2">
                                            <input type="checkbox" class="targeting" name="ad_product_view" id="ad_product_view" value="product_view" {if $product.target_sec_id[1]=='product_view'}checked{/if} data-parsley-mincheck="1">
                                            <span class="checkmark"></span> <label for="ad_product_view">Product view page</label>
                                        </div>
                                        <div class="cus-check form-group1 suply2">
                                            <input type="checkbox" class="targeting" name="ad_dashboard" id="ad_dashboard" value="dashboard" {if $product.target_sec_id[1]=='dashboard'}checked{/if} data-parsley-mincheck="1">
                                            <span class="checkmark"></span> <label for="ad_dashboard">Dashboard</label>
                                        </div>
                                        <div class="cus-check form-group1 suply2">
                                            <input type="checkbox" class="targeting" name="ad_product_post" id="ad_product_post" value="product_post" {if $product.target_sec_id[1]=='product_post'}checked{/if} data-parsley-mincheck="1">
                                            <span class="checkmark"></span> <label for="ad_product_post">Post a product</label>
                                        </div>
                                    </div>
                                    <div id="errorTargeting" class="parsley-errors-list"></div>
                                </div>
                            </div>

                            <div class="row" style="display: none;">
                                <div class="col-12 form-group">
                                    <label class="pp-label">Day of the Week*</label>
                                    <div class="clearfix">
                                        <div class="cus-check form-group1 suply2">
                                            <input type="checkbox" class="week_day" name="ad_sunday" id="ad_sunday" value="sunday" {if $product.day_of_week[1]=='sunday'}checked{/if} data-parsley-mincheck="1" data-parsley-errors-container="#errorWeek">
                                            <span class="checkmark"></span> <label for="ad_sunday">SUNDAY</label>
                                        </div>
                                        <div class="cus-check form-group1 suply2">
                                            <input type="checkbox" class="week_day" name="ad_monday" id="ad_monday" value="monday" {if $product.day_of_week[1]=='monday'}checked{/if} data-parsley-mincheck="1">
                                            <span class="checkmark"></span> <label for="ad_monday">MONDAY</label>
                                        </div>
                                        <div class="cus-check form-group1 suply2">
                                            <input type="checkbox" class="week_day" name="ad_tuesday" id="ad_tuesday" value="tuesday" {if $product.day_of_week[1]=='tuesday'}checked{/if} data-parsley-mincheck="1">
                                            <span class="checkmark"></span> <label for="ad_tuesday">TUESDAY</label>
                                        </div>
                                        <div class="cus-check form-group1 suply2">
                                            <input type="checkbox" class="week_day" name="ad_wednesday" id="ad_wednesday" value="wednesday" {if $product.day_of_week[1]=='wednesday'}checked{/if} data-parsley-mincheck="1">
                                            <span class="checkmark"></span> <label for="ad_wednesday">WEDNESDAY</label>
                                        </div>
                                        <div class="cus-check form-group1 suply2">
                                            <input type="checkbox" class="week_day" name="ad_thursday" id="ad_thursday" value="thursday" {if $product.day_of_week[1]=='thursday'}checked{/if} data-parsley-mincheck="1">
                                            <span class="checkmark"></span> <label for="ad_thursday">THURSDAY</label>
                                        </div>
                                        <div class="cus-check form-group1 suply2">
                                            <input type="checkbox" class="week_day" name="ad_saturday[]" id="ad_friday" value="friday" {if $product.day_of_week[1]=='friday'}checked{/if} data-parsley-mincheck="1">
                                            <span class="checkmark"></span> <label for="ad_friday">FRIDAY</label>
                                        </div>
                                        <div class="cus-check form-group1 suply2">
                                            <input type="checkbox" class="week_day" name="ad_saturday[]" id="ad_saturday" value="saturday" {if $product.day_of_week[1]=='saturday'}checked{/if} data-parsley-mincheck="1" >
                                            <span class="checkmark"></span> <label for="ad_saturday">SATURDAY</label>
                                        </div>
                                    </div>
                                    <div id="errorWeek" class="parsley-errors-list"></div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-12 form-group">
                                    <label class="pp-label">Keywords</label>
                                    <div class="clearfix">
                                        <input class="form-control" placeholder="Keywords" name="ad_keywords" id="ad_keywords" value="{$product.keywords}" />
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-sm-6 form-group">
                                    <label class="pp-label">Campaign Budget</label>
                                    <div class="clearfix">
                                        <input class="form-control" placeholder="Enter the maximum you are willing to pay per click" name="ad_budget_perclick" id="ad_budget_perclick" required data-parsley-required-message="Maximum amount is required." value="{$product.ad_budget_perclick}" min="2" data-parsley-trigger="change" />
                                        <span style="color: darkgrey;">Minimum Amount: US$2 Per Click</span>
                                    </div>
                                </div>
                                <div class="col-sm-6 form-group">
                                    <label class="pp-label">&nbsp;</label>
                                    <div class="clearfix">
                                        <input class="form-control" placeholder="Enter your total budget for the Ad" name="ad_spend_perday" id="ad_spend_perday" required data-parsley-required-message="Per day amount is required." value="{$product.ad_spend_perday}" min="5" data-parsley-trigger="change" />
                                        <span style="color: darkgrey;">Minimum Budget: US$5.00 Per Day</span>
                                    </div>
                                    <span class="parsley-errors-list" style="display: none;" id="multiplies_budget_error"></span>
                                </div>
                            </div>
                            <div class="row">
                                <div style="margin: auto;">
                                    <a class="btn btn-primary" style="width: 130px;" href="/advertisements">CANCEL</a>&nbsp;&nbsp;
                                    <button id="final_submit" class="btn btn-brown" style="font-size: 12px; width: 130px;">CREATE</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
         </div>
    </div>
</section>
<input type="hidden" name="page" value="{$currentPage}" id="page">

{include file="/common/footer-1.tpl" nocache}

{foreach $allProducts as $key => $val}
{include file="time-loader.tpl" nocache}
{/foreach}

<script language="javascript" type="text/javascript">

    var config_url = '{$config.url}';
    $(document).ready(function () {
        $('#ad_end_date').datetimepicker({
            //format:'Y-m-d H:i',
            format:'m-d-Y',
            timepicker:false,
            step: 5,
            minDate:new Date()
        });

        $(document).on('submit', '#create_ads_form', function(e){
            e.preventDefault();
            /* console.log('$(".week_day:checked").length', $(".week_day:checked").length);
            if($(".week_day:checked").length < 1) {
                $("#ad_sunday").attr('required', 'required');
            } else {
                $("#ad_sunday").attr('required', false);
                $("#ad_sunday").trigger('change');
                $("#ad_sunday").parsley().reset(); */
                // saveAd();
            /* } */

            if($(".targeting:checked").length < 1) {
                $("#ad_home").attr('required', 'required');
            } else {
                $("#ad_home").attr('required', false);
                $("#ad_home").trigger('change');
                $("#ad_home").parsley().reset();
                saveAd();
            }
        });
        $(document).on('change', '.targeting', function(e){
            if($(".targeting:checked").length < 1) {
                $("#ad_home").attr('required', 'required');
            } else {
                $("#ad_home").attr('required', false);
                $("#ad_home").parsley().destroy();
                $("#create_ads_form").parsley().reset();
            }
        });
        $(document).on('change', '.week_day', function(e){
            if($(".week_day:checked").length < 1) {
                $("#ad_sunday").attr('required', 'required');
            } else {
                $("#ad_sunday").attr('required', false);
                $("#ad_sunday").parsley().destroy();
                $("#create_ads_form").parsley().reset();
            }
        });
        $(document).on('change', 'input[name=add_type]', function() {
            console.log('$(this).val()', $(this).val());
            if($(this).val() == '2') {
                $("#specific_date_div").show();
            } else {
                $("#ad_end_date").val('');
                $("#specific_date_div").hide();
            }
        });
        $(document).on('change', '#bannerDocument', function() {
            $("#iError").hide();
        });
        $(document).on('change', '#ad_url', function() {
            $("#urlError").hide();
        });
        
    });

    function saveAd() {
        var url = $("#ad_url").val();
        $("#urlError").hide();
        if(/^(https?|s?ftp):\/\/(((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:)*@)?(((\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])\.(\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])\.(\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])\.(\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5]))|((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.?)(:\d*)?)(\/((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)+(\/(([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)*)*)?)?(\?((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)|[\uE000-\uF8FF]|\/|\?)*)?(#((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)|\/|\?)*)?$/i.test(url) == false) {
            $("#urlError").show();
            $("#ad_url").focus();
            return true;
        }
        var images = $("#bannerDocument")[0].files;
        $("#iError").hide();
        if(images.length < 1) {
            $("#iError").show();
            return true;
        }
        $("#multiplies_budget_error").hide();
        var per_click = $("#ad_budget_perclick").val();
        var per_day = $("#ad_spend_perday").val();
        if(per_day%per_click != 0) {
            var message = 'Budget per day multiple of ' + per_click;
            $("#multiplies_budget_error").html(message);
            $("#multiplies_budget_error").show();
            $("#ad_spend_perday").focus();
            return true;
        }
        
        var formArr = $("#create_ads_form").serializeArray();
        var dataObj = {};
        var productData = formArr ? formArr : [];
        if(productData.length) {
            for (var index = 0; index < productData.length; index++) {
                const element = productData[index];
                dataObj[productData[index].name] = productData[index].value;
            }
        }
        dataObj['ad_banner'] = banners;
        $("#final_submit").attr('disabled', 'disabled');
        $.ajax({
            method: "POST",
            url: '/save_ad',
            data: dataObj,
            dataType: 'JSON',
            cache: false,
            success: function (data) {
                if(data.success) {
                    swal({ title: "Ad added successfully" }, function() {
                        window.location.href = '/advertisements';
                    });
                } else {
                    window.location.reload();
                }
                $("#final_submit").attr('disabled', false);
                //clearForm();
            }
        });
    }
    /* Start Upload Banner */
    var banners = '';
    function editBannerFileupload(obj)
    {
        $("#final_submit").attr("disabled", "disabled");
        var files = $('input[name="bannerDocument"]')[0].files;
        var formData = new FormData();
        for (let index = 0; index < files.length; index++) {
            const element = files[index];
            formData.append('banners', element);
        }
        $("#bannerDocumentLoader").show();
        var cntfle = $('input[name="bannerDocument"]')[0].files.length;
        $.ajax({
            url : '/postbanners/'+cntfle,
            type : 'POST',
            xhr: function() {
                var myXhr = $.ajaxSettings.xhr();
                return myXhr;
            },
            data : formData,
            processData: false,
            contentType: false,
            success : function(response) {
                if(response.banners.length) {
                    // createBannerHtml(response.banners);
                    banners = response.banners[0].name;
                    $("#banners_name_div").html(banners);
                    $("#banners_name_div").attr('href', config_url+'/uploads/banners/'+banners);
                }
                // $("#loading_images").hide();
                $("#final_submit").attr("disabled", false);
            },
            error: function(e)
            {
                $("#final_submit").attr("disabled", false);
                console.log(e);
            },
        }).done(function() {
            $("#final_submit").attr("disabled", false);
            $("#bannerDocumentLoader").hide();
        });
    }
    /* End Upload Banner */
</script>