{include file="/common/header-1.tpl" nocache}

<!-- <div class="clearfix auth-container" style="padding-top: 100px !important;"> -->
<section class="db-wrapper db-iwrap">
    {include file="/common/header-2.tpl" nocache}
    <div class="container">
        <div class="row">
            <div class="col-sm-6">
                <h3 class="acc-head">
                    MY AUCTION (ACTIVE)
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
                    <li><a href='/buyer/activeAuction' class="active">Active</a></li>
                    <li><a href='/buyer/wonAuction' class="">Auctions Won</a></li>
                    <li><a href='/buyer/lostAuction' class="">Auctions Lost</a></li>
                    <li><a href='/buyer/buyAuction' class="">Products Purchased</a></li>
                    <li><a href='/buyer/watchlist' class="">Watchlist</a></li>
                </ul>
            </div>
            <div class="db-right-con">
                <form action="{$config.url}/buyer/activeAuction" method="post">
                    <div id="activeProductSection">              
                        {include file="hmb_active_product_template.tpl" nocache}
                    </div>
                </form>
            </div>
         </div>
    </div>
</section>

<section class="search-content-wrap og-auc-wrap">
    <div class="container spl-wrap">
        <h2 class="on-ahead">ADVERTISEMENTS</h2>
        <div id="ads_list"></div>
    </div>
</section>
<input type="hidden" name="page" value="{$currentPage}" id="page">

{include file="/common/footer-1.tpl" nocache}

{foreach $allProducts as $key => $val}
{include file="time-loader.tpl" nocache}
{/foreach}

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
        $('#carousel').flexslider({
            animation: "slide",
            controlNav: false,
            animationLoop: false,
            slideshow: false,
            itemWidth: 70,
            itemMargin: 10,
            asNavFor: '#slider'
        });

        $('#slider').flexslider({
            animation: "slide",
            controlNav: false,
            animationLoop: false,
            slideshow: false,
            sync: "#carousel"
        });
        
        searchForm();
    });

    $('body').on('change', '#sort_by', function() {
        searchForm();
    });

    function searchForm() {
        $('#activeProductSection').html('');
        $.ajax({
            type : 'POST',
            url  : '/buyerSearchAuctionPage',
            //data :  { page : $('#page').val(), status : "'open'" },
            data :  { page : $('#page').val(), status : "'open'", sort_by : $('#sort_by').val() },
            dataType : 'json',
            success  : function(data) {
                $('#sort_by').val($('#sort_by').val());
                $('input[name="page"]').val(1);
                $('#activeProductSection').html(data.html);
            }
        });
    }
</script>