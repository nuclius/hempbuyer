{include file="/common/header-1.tpl" nocache}
<style>
    .text-green {
        color: #5e9836;
        font-size: 24px;
        cursor: pointer;
        margin-right: 5px;
    }
    #view_ad_detail .row {
        padding: 7px;
    }
</style>
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
        <div class="row">
            <div class="col-md-6 form-group">
                <a class="btn advertise_btn {if $activePage=='advertisement'}active{/if}" href="/advertisement">
                    Create Advertisement
                </a>
                <a class="btn advertise_btn {if $activePage=='advertisements'}active{/if}" href="/advertisements">
                    Ads List
                </a>
            </div>

            <div class="col-md-6 form-group tright-md">
                <label><b>Ads Wallet Balance</b></label> - $<span id="total_amount">0.00</span>
            </div>
        </div> 
         <div class="db-content">
            <div class="db-right-con">
                <form id="ads_form" style="display: none;">
                    <input type="hidden" name="page" id="page" value="1">
                    <input type="hidden" name="action" id="action" value="advertisements_list">
                    <input type="hidden" name="limit" id="limit" value="10">
                </form>
                <div id="ads_list" style="margin-bottom: 30px;">
                </div>
            </div>
         </div>
    </div>
</section>

<div class="modal fade hb-modal" id="view_ad_detail" data-backdrop="static" data-keyboard="false">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <img src="{$config.url}/images/logo.png" class="m-auto" />
                
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    <i class="fa fa-times-circle"></i>
                </button>
            </div>
            <div class="modal-body">
                <h4 class="text-center">YOU HAVE BEEN SUCCESSFULLY REGISTERED</h4>
                <div class="row">
                    <div class="col-sm-3"><b>Ad Name:</b></div>
                    <div class="col-sm-9" id="ad_name"></div>
                </div>
                <div class="row">
                    <div class="col-sm-3"><b>Ad Title:</b></div>
                    <div class="col-sm-9" id="ad_title"></div>
                </div>
                <div class="row">
                    <div class="col-sm-3"><b>Ad Content:</b></div>
                    <div class="col-sm-9" id="ad_content"></div>
                </div>
                <div class="row">
                    <div class="col-sm-3"><b>Ad Url:</b></div>
                    <div class="col-sm-9" id="ad_url"></div>
                </div>
                <div class="row">
                    <div class="col-sm-3"><b>Target Section:</b></div>
                    <div class="col-sm-9" id="target_sec_id"></div>
                </div>
                <div class="row">
                    <div class="col-sm-3"><b>Keywords:</b></div>
                    <div class="col-sm-9" id="keywords"></div>
                </div>
                <div class="row">
                    <div class="col-sm-3"><b>budget per click:</b></div>
                    <div class="col-sm-9" id="budget_per_click"></div>
                </div>
                <div class="row">
                    <div class="col-sm-3"><b>Budget per day:</b></div>
                    <div class="col-sm-9" id="budget_per_day"></div>
                </div>
                <div class="row">
                    <div class="col-sm-3"><b>Created Date:</b></div>
                    <div class="col-sm-9" id="created_at"></div>
                </div>
            </div>
        </div>
    </div>
</div>

{include file="/common/footer-1.tpl" nocache}

{foreach $allProducts as $key => $val}
{include file="time-loader.tpl" nocache}
{/foreach}

<script language="javascript" type="text/javascript">
    var config_url = '{$config.url}';
    $(document).ready(function () {
        $(document).on('submit', '#create_ads_form', function(e){
            e.preventDefault();
            console.log('$(".week_day:checked").length', $(".week_day:checked").length);
            if($(".week_day:checked").length < 1) {
                $("#ad_sunday").attr('required', 'required');
            } else {
                $("#ad_sunday").attr('required', false);
                $("#ad_sunday").trigger('change');
                $("#ad_sunday").parsley().reset();
                saveAd();
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

        getAds();
    });

    function getAds() {
        var formArray = $("#ads_form").serializeArray();
        var Obj = {};
        var productData = formArray ? formArray : [];
        if(productData.length) {
            for (var index = 0; index < productData.length; index++) {
                const element = productData[index];
                Obj[productData[index].name] = productData[index].value;
            }
        }
        console.log('Obj', Obj);

        $.ajax({
            type: 'POST',
            url: '/advertisements_list',
            data: Obj,
            // dataType: 'json',
            success: function(data) {
                // console.log('data', data);
                $("#ads_list").html(data);
                $("#pagination_html").html(pagination(paginationData));

            }

        });
    }
    function changeStatus(id, status) {
        var formArray = $("#ads_form").serializeArray();
        var Obj = {
            id: id,
            status: status
        };
        $.ajax({
            type: 'POST',
            url: '/update_ad_status',
            data: Obj,
            // dataType: 'json',
            success: function(data) {
                if(data.success) {
                    if(status == 'active') {
                        $("#add_play_"+id).hide();
                        $("#add_pause_"+id).show();
                    } else if(status == 'pause') {
                        $("#add_pause_"+id).hide();
                        $("#add_play_"+id).show();
                    } else {
                        getAds();
                    }
                    swal('Status updated successfully');
                }
            }
        });
    }
    function viewDetail(ad_id) {
        var formArray = $("#ads_form").serializeArray();
        var Obj = {
            id: ad_id
        };
        console.log('Obj', Obj);

        $.ajax({
            type: 'POST',
            url: '/get_ad_details',
            data: Obj,
            // dataType: 'json',
            success: function(data) {
                if(data.status == 200) {
                    var result = data.result;
                    $("#ad_name").html(result.ad_name);
                    $("#ad_title").html(result.ad_title);
                    $("#ad_content").html(result.ad_content);
                    $("#ad_url").html('<a href="'+result.ad_url+'" target="_blank">'+result.ad_url+'</a>');
                    $("#target_sec_id").html(result.target_sec_id);
                    $("#keywords").html(result.keywords);
                    $("#budget_per_click").html('$'+result.budget_per_click);
                    $("#budget_per_day").html('$'+result.budget_per_day);
                    $("#created_at").html(result.created_at);

                    $("#view_ad_detail").modal();
                }

            }

        });
    }
</script>