{include file="/common/header-1.tpl" nocache}

<!-- <div class="clearfix auth-container" style="padding-top: 100px !important;"> -->
<section class="db-wrapper db-iwrap">
    {include file="/common/header-2.tpl" nocache}
    <div class="container">
        <div class="row">
            <div class="col-sm-6">
                <h3 class="acc-head">
                    MY AUCTION (CLOSED AUCTIONS)
                </h3>
            </div>
            <div class="col-sm-6">
                <div class="form-inline wt-wrap">
                    <div class="clearfix cselec-wrap">
                        <select class="custom-select" name="sort_by" id="sort_by">
                            <option value="">Sort By</option>
                            <option value="price_asc">Price: Low - High</option>
                            <option value="price_desc">Price: High - Low</option>
                            <option value="startdate_asc">Start Date: Asc - Desc</option>
                            <option value="startdate_desc">Start Date: Desc - Asc</option>
                            <option value="enddate_asc">End Date: Asc - Desc</option>
                            <option value="enddate_desc">End Date: Desc - Asc</option>
                            <option value="id_asc">Oldest</option>
                            <option value="id_desc" selected>Newest</option>
                        </select>
                    </div>
                </div>
            </div>
        </div>
         <div class="db-content">
            <div class="db-menu">
                <ul class="">
                    <li><a href='/seller/openAuction' class="">Posted Products</a></li>
                    <li><a href='/seller/soldAuction' class="">Products Sold</a></li>
                    <li><a href='/seller/draftAuction'>Drafts</a></li>
                    <li><a href='/seller/closedAuction' class="active">Closed Auctions</a></li> 
                </ul>
            </div>
            <div class="db-right-con">
                <form action="{$config.url}/seller/closedAuction" method="post">
                    <div id="closedProductSection">              
                        {include file="hmb_closed_product_template.tpl" nocache}
                    </div>
                </form>
            </div>
         </div>
    </div>
</section> 
<input type="hidden" name="page" value="{$currentPage}" id="page">

<section class="search-content-wrap og-auc-wrap">
    <div class="container spl-wrap">
        <h2 class="on-ahead">ADVERTISEMENTS</h2>
        <div id="ads_list"></div>
    </div>
</section>

{include file="/common/footer-1.tpl" nocache}

<script language="javascript" type="text/javascript">
    getAds();
    function getAds() {
        var Obj = {
            page: 'dashboard'
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
    $(document).ready(function () {
        searchForm();
    });

    $('body').on('change', '#sort_by', function() {
        searchForm();
    });

    function searchForm() {
        $('#closedProductSection').html('');
        $.ajax({
            type : 'POST',
            url  : '/searchAuctionPage',
            data :  { page : $('#page').val(), status : "'closed'", sort_by : $('#sort_by').val() },
            dataType : 'json',
            success  : function(data) {
                $('#sort_by').val($('#sort_by').val());
                $('input[name="page"]').val(1);
                $('#closedProductSection').html(data.html);
            }
        });
    }
</script>