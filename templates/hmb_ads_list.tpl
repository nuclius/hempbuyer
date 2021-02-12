<style>
    .search-content-wrap .spl-wrap .owl-ads .card {
        margin: 0 auto 35px;
        height: auto;
    }
    .owl-ads.owl-theme .owl-nav {
        margin-top: 0px;
    }
    /* .owl-theme .owl-nav {
        margin-top: 10px;
        position: absolute;
        top: 45%;
        width: 100%;
        transform: translate(0%, -100%);
    }
    .owl-theme .owl-nav .owl-prev {
        float: left;
        margin-left: -30px;
        font-size: 20px;
        width: 30px;
        height: 30px;
        line-height: 6px;
    }
    .owl-theme .owl-nav .owl-next {
        float: right;
        margin-right: -21px;
        font-size: 20px;
        width: 30px;
        height: 30px;
        line-height: 6px;
    } */
</style>
{if $ads_list.length}
<div class="owl-ads owl-carousel owl-theme">
    {foreach $ads_list as $key => $val}
        <div class="item" style="width:auto">
            <div class="card">
                <a target="_blank" href="javascript:void(0)" onclick="clickAd({$val.id}, '{$val.ad_url}')">
                    {if !$val.banner}
                        <img class="card-img-top" src="/no_image.png" alt="No Image Available" onerror="this.onerror=null;this.src='/no_image.png';" style="width: 250px; height: 200px;" />
                    {else/}
                        <img class="card-img-top" src="/uploads/banners/{$val.banner}" alt="No Image Available" onerror="this.onerror=null;this.src='/no_image.png';" style="width: 250px; height: 200px;" />
                    {/if}
                </a>
                <div class="upcoming">Ads</div>
            </div>
        </div>
    {/foreach}
</div>
{/if}
<script>
$(document).ready(function(){
    var total_ads = +'{$ads_list.length}';
    if(total_ads < 1) {
        $("#ads_list").closest("section").remove();
        $("#ads_list1").closest("section").remove();
    }

    $('.owl-ads').owlCarousel({
        items: 1,
        loop: false,
        rewind: true,
        margin: 20,
        dot: false,
        nav: true,
        autoWidth: true,
        autoplay: true,
        autoplayTimeout: 30000,
        autoplayHoverPause: true,
        responsive: {
            0: {
                items: 1
            },
            500: {
                items: 2
            },
            800: {
                items: 4
            },
            1000: {
                items: 4
            }
        }
    });
});
function clickAd(id, url) {
    console.log('id', id);
    var dataObj = {
        id: id
    };
    $.ajax({
        method: "POST",
        url: '/click_ad',
        data: dataObj,
        dataType: 'JSON',
        cache: false,
        success: function (data) {
            var totalClick = data.result.budget_per_day / data.result.budget_per_click;
            var availableClick = totalClick - (data.result.no_of_clicks + 1);
            if(availableClick < 1) {
                getAds();
            }
        }
    });
    window.open(url, '_blank');
}
</script>