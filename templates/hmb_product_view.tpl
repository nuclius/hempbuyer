{include file="/common/header-1.tpl" nocache}
<!-- page content  -->
<style>

.tooltip {
    top: -6px !important;
}
.tooltip .arrow::before {
    border-right-color: transparent;
}
.tooltip-inner {
    color: #ffffff;
    background: #585858;
}
#chat_message {
    width: calc(100% - 90px);
    border-radius: 0px;
}
.unread_count {
    float: right;
    background: #ff0000;
    color: #ffffff;
    padding: 3px 5px;
    border-radius: 50%;
    font-size: 12px;
    min-width: 23px;
    text-align: center;
    position: absolute;
    right: -8px;
    top: -6px;
}
#rate-history_tab .bhis-box {
    height: auto !important;
}
#rate-history_tab .bhis-box .row {
    height: auto !important;
    align-items: center;
}
</style>
{* <script src="//platform.linkedin.com/in.js" type="text/javascript"> lang: en_US</script>
<script type="IN/Share" data-url="https://hempbuyer.auctionsoftware.com/product/view/155" data-counter="top"></script> *}

{* <meta property="og:url"                content="{$config.url}/product/view/{$previewData.id}" />
<meta property="og:type"               content="website" />
<meta property="og:title"              content="{$previewData.title}" />
<meta property="og:description"        content="{$previewData.description}" />
<meta property="og:image"              content="{$config.url}/uploads/product/{$previewData.productDocument[0].image}" /> *}

<script language="javascript">
    var title = encodeURIComponent(`{$previewData.title}`);
    var description = encodeURIComponent(`{$previewData.description}`);
    var link = window.location.href;
    if('{$config.url}' == 'http://localhost:2099') {
        var link = 'https://hempbuyer.auctionsoftware.com/product/view/155';
    }
    console.log('link', encodeURIComponent(link));
    var website_name = 'hempbuyer';
    $(document).ready(function() {
        $('[data-toggle="tooltip"]').tooltip();
    });

    function fbshareCurrentPage() {
        window.open("https://www.facebook.com/sharer/sharer.php?u="+encodeURIComponent(link)+"&t="+title, '', 'menubar=no,toolbar=no,resizable=yes,scrollbars=yes,height=300,width=600');
        return false;
    }
    function linkedinshareCurrentPage() {
        window.open('https://www.linkedin.com/shareArticle?mini=true&url='+encodeURIComponent(link)+'&title='+encodeURIComponent(title)+'&summary='+description);
        return false;
    }
    function twittershareCurrentPage() {
        window.open('https://twitter.com/intent/tweet?url='+encodeURIComponent(link)+'&text='+title+'&hashtags='+website_name+'');
        return false;
    }
    function instashareCurrentPage() {
        //window.open('https://twitter.com/intent/tweet?url='+encodeURIComponent(link)+'&text='+title+'&hashtags='+website_name+'');
        return false;
    }
    function copyCurrentPage() {
        var copyText = document.getElementById("url_input");
        copyText.disabled = false;
        copyText.value = link;
        copyText.select();
        // copyText.setSelectionRange(0, 99999);
        document.execCommand("copy");
        copyText.disabled = true;
        
        var text = 'Link copied';
        $("#copy_social").attr('tooltip', text);
        $("#copy_social").attr('data-original-title', text);
        $(".tooltip-inner").html(text);
        setTimeout(function() {
            var text = "Copy to clipboard";
            $("#copy_social").attr('tooltip', text);
            $("#copy_social").attr('data-original-title', text);
            $(".tooltip-inner").html(text);
        }, 5000)
        
        /* var text = window.location.href;
        navigator.clipboard.writeText(text).then(function() {
            var text = 'Link copied';
            $("#copy_social").attr('tooltip', text);
            $("#copy_social").attr('data-original-title', text);
            $(".tooltip-inner").html(text);
        }, function(err) {
            // console.error('Async: Could not copy text: ', err);
        }); */
    }

    $(document).ready(function () {
        setTimeout(function() {
            $(".block__pic").imagezoomsl({
                zoomrange: [3, 3],
                zindex: 99,
                scrollspeedanimate: 5 ,
                zoomspeedanimate: 7,
                loopspeedanimate: 2.5,  
                magnifierspeedanimate: 350
            });
        }, 1000);
    });

</script>

<div class="search-container profile-container">
    <div class="">
        <input disabled id="url_input" style="position:fixed;top:-5rem;height:1px;width:10px;">
        <div class="col-sm-11 text-right">
            <a class="social_tag" title="Facebook" onclick="fbshareCurrentPage()" target="_blank" alt="Share on Facebook" data-toggle="tooltip"><i class="fab fa-facebook-f"></i></a>
            <a class="social_tag" title="Linkedin" onclick="linkedinshareCurrentPage()" target="_blank" alt="Share on Linkedin" data-toggle="tooltip"><i class="fab fa-linkedin-in"></i></a>
            <a class="social_tag" title="Twitter" onclick="twittershareCurrentPage()" data-toggle="tooltip"><i class="fab fa-twitter"></i></a>
            {* <a class="social_tag" title="Instagram" onclick="instashareCurrentPage()" data-toggle="tooltip"><i class="fab fa-instagram"></i></a> *}
            <a class="social_tag" id="copy_social" title="Copy to clipboard" onclick="copyCurrentPage()" data-toggle="tooltip"><i class="far fa-copy"></i></a>

        </div>
    </div>

    <div class="container">
        <div class="res-proview" style="display: inline-block;">
            <div class="media pv-media" style="margin: 0px; float: left;">
                <div class="media-left">
                    <div id="slider" class="flexslider">
                        <ul class="slides">
                            {foreach $previewData.productDocument as $key => $val}
                            <li>
                                {if $val.type=='video'} 
                                    <iframe height="272" width="490" src="{$val.image}"></iframe>
                                {else /}
                                    {if $currentUser > -1 && $currentUser != $previewData.user_id && $previewData.market_status!='closed'}
                                        {if $previewData.watchlistFlag.length > 0}
                                            {if $previewData.watchlistFlag[0]['status'] == 'inactive'}
                                                <i class="fa fa-heart addToWatchlist" title="Add to Watchlist" data-product_id="{$previewData.id}" data-status="active"></i>
                                            {else if $previewData.watchlistFlag[0]['status'] == 'active' /}
                                                <i class="fa fa-heart addToWatchlist addedInWatchlist" title="Added in Watchlist" data-product_id="{$previewData.id}" data-status="inactive"></i>
                                            {/if}
                                        {else/}
                                            <i class="fa fa-heart addToWatchlist" title="Add to Watchlist" data-product_id="{$previewData.id}" data-status="active"></i>
                                        {/if}
                                    {/if}
                                    <img class="block__pic" src="{$config.url}/uploads/product/{$val.image}" alt="{$val.originalname}" onerror="this.onerror=null;this.src='{$config.url}/no_image.png';" style="height:272px; width:490px; margin:auto;" />
                                {/if}
                            </li>
                            {/foreach}
                        </ul>
                    </div>
                    <div id="carousel" class="flexslider">
                        <ul class="slides">
                            {foreach $previewData.productDocument as $key => $val}
                            <li>
                                {if $val.type=='video'}
                                    <!-- <video src="{$config.url}/uploads/product/{$val.avatar}" type="{$val.mimetype}" onerror="this.onerror=null;this.src='{$config.url}/no_video.png';" style="height: 60px; width: 60px;"> -->
                                    <img src="{$config.url}/video_play_icon.png" onerror="this.onerror=null;this.src='{$config.url}/no_image.png';" style="width: 60px; height: 60px;" />
                                {else /}
                                    <img src="{$config.url}/uploads/product/{$val.avatar}" alt="{$val.originalname}" onerror="this.onerror=null;this.src='{$config.url}/no_image.png';" style="height: 60px; width: 60px;" />
                                {/if}
                            </li>
                            {/foreach}
                        </ul>
                    </div>
                    {if $previewData.user_id != $loged.userid && $previewData.type != 'offer' && $currentUser > -1 && $previewData.market_status == "open"}
                        <div class="text-center">
                            <a type="button" type="button" id="open-offered-messages_{$previewData.id}" class="" type="button" style="margin-top:15px;position: relative;" onclick="offerContactSellerChat()" id="buyNowBtn" title="Chat with seller">
                                <i class="fa fa-envelope fa-3x"></i>
                                <span class="unread_count" style="{if !$unread_count}display: none;{/if}">{$unread_count}</span>
                            </a>
                        </div>
                    {/if}
                </div>
                <div class="media-body" style="width: 346px;">
                    <h5 class="mb-2">
                        #{$previewData.product_tracking_id}
                    </h5>
                    <h3 class="pv-title">
                        {$previewData.title}
                    </h3>
                    <div class="pv-timer1 text-capitalize" id="my{$previewData.id}" data-enddate="{$previewData.end_date}">06D : 08H : 05M : 03S</div>
                    {if $previewData.type == 'auction'}
                    <div class="pv-con">
                        Start Bid : {if $loged.userid}${$previewData.start_price}{else/}-{/if}
                    </div>
                    <div class="pv-con">
                        Total Bids : {if $loged.userid}<a class="pp-txt" id="total_bid">{if $bidHistory[0].totalBid} {$bidHistory[0].totalBid} {else/} 0 {/if}</a>{else/}-{/if}
                    </div>
                    <div class="pv-con">
                        {if !$previewData.win_price}
                            Current Bid : {if $loged.userid}$<span id="last_bid">0</span>{else/}-{/if}
                        {else /}
                            Current Bid : {if $loged.userid}$<span id="last_bid">{$previewData.win_price}</span>{else/}-{/if}
                        {/if}
                    </div>
                    {/if}

                    {if $previewData.type == 'offer'}
                        <div class="pv-con">
                            Offer Price : <span id="offer_price_div">{if $loged.userid}${$previewData.offer_price}{else/}-{/if}</span>
                        </div>
                        <!-- <div class="pv-con">
                            Offer Qty : {if $loged.userid}{$previewData.offer_qty} {if $previewData.unit_of_measurement!='' and $previewData.unit_of_measurement!='0'} per {$previewData.unit_of_measurement} {/if}{else/}-{/if}
                        </div> -->
                    {/if}

                    <!-- {if $previewData.type != 'offer'}
                        <div class="pv-con">
                            Available Qty : {if $loged.userid}<span id="lots_available">{$previewData.lots_available}</span> {if $previewData.unit_of_measurement!='' and $previewData.unit_of_measurement!='0'} {$previewData.unit_of_measurement} {/if}{else/}-{/if}
                        </div>
                    {/if} -->

                    {if $previewData.type == 'auction' && $previewData.is_buynow == 1}
                    <div class="pv-con">
                        Buy Now Price : {if $loged.userid}${$previewData.buynow_price} {if $previewData.unit_of_measurement!='' and $previewData.unit_of_measurement!='0'} per {$previewData.unit_of_measurement} {/if}{else/}-{/if}
                    </div>
                    <div class="pv-con">
                        Minimum Qty : {if $loged.userid}{$previewData.buynow_qty} {if $previewData.unit_of_measurement!='' and $previewData.unit_of_measurement!='0'} {$previewData.unit_of_measurement} {/if}{else/}-{/if}
                    </div>

                    <!-- <div class="pv-con grn-txt">
                        Buy Now Qty : {$previewData.buynow_qty} {if $previewData.unit_of_measurement!='' and $previewData.unit_of_measurement!='0'} {$previewData.unit_of_measurement} {/if}
                    </div> -->

                    {/if}

                    {if $previewData.type == 'fixed'}
                    <div class="pv-con">
                        Buy Now Price : {if $loged.userid}${if $previewData.fixed_price}{$previewData.fixed_price}{else /}{$previewData.buynow_price}{/if} {if $previewData.unit_of_measurement!='' and $previewData.unit_of_measurement!='0'} per {$previewData.unit_of_measurement} {/if}{else/}-{/if}
                    </div>
                    <div class="pv-con">
                        Minimum Qty : {if $loged.userid}{$previewData.fixed_qty} {if $previewData.unit_of_measurement!='' and $previewData.unit_of_measurement!='0'} {$previewData.unit_of_measurement} {/if}{else/}-{/if}
                    </div>
                    {/if}

                    {if $loged.userid && $previewData.type == 'auction'}
                        {if $previewData.current_user_bidded > 0}
                            {if $loged.userid == $previewData.highest_bid_user_id}
                                {if $previewData.market_status=='open' && $previewData.reserve_price <= $previewData.win_price}
                                    <div class="bidder_status text-success">You are the higher bidder</div>
                                {elseif $previewData.reserve_price > $previewData.win_price}
                                    <div class="bidder_status text-danger">You lost this product</div>
                                {else /}
                                    <div class="bidder_status text-success">Congratulations you have been won this product</div>
                                {/if}
                            {else /}
                                {if $previewData.market_status=='open'}
                                    <div class="bidder_status text-danger">You have been out bidded</div>
                                {else /}
                                    <div class="bidder_status text-danger">You lost this product</div>
                                {/if}
                            {/if}
                        {else /}
                            <div class="bidder_status" style="display: none"></div>
                        {/if}
                    {/if}
                    {if $currentUser > -1 && $currentUser != $previewData.user_id && $previewData.market_status=='open'}
                        <form class="row sb-wrap mt-3">
                            {if $previewData.auction_active}
                                {if $previewData.type == 'auction'}
                                <div class="col-12" id="bid_amount_div">
                                    <input {if  $previewData.type != 'auction'} disabled{/if} class="form-control"  type="number" min="0" step="1" placeholder="Enter Amount $" id="bidInput" onkeypress="return event.charCode >= 48 && event.charCode <= 57" onblur="($('#bidInput').val().length <= 0 ? $('#errMsg').show() :  $('#errMsg').hide())" required>
                                    <div style="display: none; color:red" id="errMsg">Please Enter Valid Amount!</div>
                                    <div class="pv-note">Enter US $<span id="next_bid_amount">{$previewData.next_bid_amount}</span> or more</div>
                                </div>
                                {/if}
                                <div class="col-12">
                                    {if $currentUser > -1}
                                        {if $previewData.type == 'auction'}
                                            <button type="button" class="btn btn-brown" type="button"  id="submitBidBtnView" onclick="resetConfirm(); validateValues()" {if $previewData.market_status != "open"} disabled {/if}>
                                                SUBMIT BID
                                            </button>
                                        {/if}
                                    {else/}
                                        <button type="button" class="btn btn-brown" type="button" onclick="window.location.replace('/signin')">
                                            SUBMIT BID
                                        </button>
                                    {/if}
                                </div>
                            {/if}
                            <div class="col-12">
                                {if $previewData.user_id != $loged.userid && $previewData.type == 'offer' && $currentUser > -1 && $previewData.market_status == "open"}
                                    <button type="button" type="button" class="btn btn-brown" type="button" style="margin-top:15px; position: relative;" onclick="offerContactSellerChat()" id="buyNowBtn" id="open-offered-messages_{$previewData.id}">
                                        Chat with seller <span class="unread_count" style="{if !$unread_count}display: none;{/if}">{$unread_count}</span>
                                    </button>
                                {/if}
                                {if $previewData.type == 'fixed' && $currentUser > -1}
                                    <button type="button" {if $previewData.market_status != "open"} disabled {/if} type="button" class="btn btn-brown" type="button" style="margin-top:15px" onclick="buyNowProduct()" id="buyNowBtn">
                                        Buy Now
                                    </button>
                                {/if}
                                {if $previewData.type == 'offer' && $currentUser > -1}
                                    <button type="button" {if $previewData.market_status != "open" || $previewData.offer_buyer_id != $loged.userid || $previewData.lots_available < $previewData.offer_qty} disabled {/if} class="btn btn-brown" style="margin-top:15px" onclick="buyNowProductOffer()" id="buyNowOfferBtn">
                                        {if $previewData.offer_buyer_id != $loged.userid && $previewData.offer_buyer_id>0}
                                            Sold
                                        {else /}
                                            Buy Now
                                        {/if}
                                    </button>
                                {/if}
                                {if $previewData.is_buynow == 1 && $previewData.type == 'auction' && $currentUser > -1}
                                    <button type="button" class="btn btn-brown" type="button" style="margin-top:15px" onclick="buyNowProduct()" id="buyNowBtn">
                                        Buy Now
                                    </button>
                                {/if}
                            </div>
                        </form>
                    {/if}
                    {if !$loged.userid}
                        <button type="button" class="btn btn-brown" type="button" onclick="window.location.replace('/signin')">
                            Bid Now
                        </button>
                    {/if}
                </div>
            </div>
            <section class="search-content-wrap og-auc-wrap" style="width: 290px; padding-top: 50px; background: unset;">
                <div class="container spl-wrap" style="padding: 0px 7px;">
                    <div id="ads_list"></div>
                </div>
            </section>
        </div>
        <div class="bids-container">
            <ul class="nav nav-tabs">
                <li class="nav-item">
                    <a href="#description_tab" data-toggle="tab" class="nav-link active">
                        DESCRIPTION
                    </a>
                </li>
                <li class="nav-item">
                    <a href="#attributes_tab" data-toggle="tab" class="nav-link">
                        ATTRIBUTES
                    </a>
                </li>
                <li class="nav-item">
                    <a href="#documents_tab" data-toggle="tab" class="nav-link">
                        DOCUMENTS
                    </a>
                </li>
                <li class="nav-item">
                    <a href="#storage_tab" data-toggle="tab" class="nav-link">
                        STORAGE/LOCATION
                    </a>
                </li>
                <li class="nav-item">
                    <a href="#sops_tab" data-toggle="tab" class="nav-link">
                        SOPs
                    </a>
                </li>
                {if $previewData.type != 'offer'}
                    <li class="nav-item">
                        <a href="#bid-history_tab" data-toggle="tab" class="nav-link">BID HISTORY</a>
                    </li>
                {/if}
                <li class="nav-item">
                    <a href="#rate-history_tab" data-toggle="tab" class="nav-link" id="rate_history">RATINGS</a>
                </li>
            </ul>
            <div class="tab-content">
                <div role="tabpanel" class="tab-pane active" id="description_tab">
                    <p class="pb-3" style="white-space: pre-line; text-align: justify;"> 
                        {$previewData.description}
                    </p>
                </div>
                <div role="tabpanel" class="tab-pane" id="attributes_tab">
                    <div class="d-inline-block">
                        {foreach $previewData.certificate_types_array as $key => $val}
                        <div class="form-group toggle_checkbox_div">
                            <input type="checkbox" checked disabled>
                            <label for="ctype_certified_organic" class="toggle_checkbox">{$val.text}</label>
                        </div>
                        {/foreach}
                    </div>
                </div>
                <div role="tabpanel" class="tab-pane" id="documents_tab">
                    <p class="">
                        <b>Date of Certificate of Analysis:</b> {$previewData.certificate_date}
                    </p>
                    <div class="d-block pb-3">
                        {foreach $certificates as $key => $val}
                            <div class="image-item" id="doc_{$key+1}">
                                {$key+1}. <a href="{$config.url}/uploads/certificates/{$val.certificate_name}" target="_blank">{$val.certificate_name}</a>
                            </div>
                        {/foreach}
                    </div>
                </div>
                <div role="tabpanel" class="tab-pane" id="storage_tab">
                    <p class="m-0">
                        <b>Date of Manufacture or Harvest:</b> {$previewData.manufacture_date}
                    </p>
                    <p class="pb-3" style="white-space: pre-line; text-align: justify;">
                        {$previewData.packaging_description}
                    </p>
                </div>
                <div role="tabpanel" class="tab-pane" id="sops_tab">
                    <p class="pb-3" style="white-space: pre-line; text-align: justify;">
                        {$previewData.sops}
                    </p>
                </div>
                <div role="tabpanel" class="tab-pane" id="bid-history_tab">
                    {if $bidHistory.length > 0}
                    {foreach $bidHistory as $key => $val}
                        <div class="bhis-box">
                            <div class="row">
                               <div class="col-2">User Name: {$val.username}</div>
                               <div class="col-2">Location: {$val.state}</div>
                               <div class="col-2">{$val.created_at}</div>
                               <div class="col-2">No of Bids: {if $loged.userid}{$val.bidCount}{else/}-{/if}</div>
                               <div class="col-2 pp-txt">BID AMOUNT: {if $loged.userid}${$val.proposed_amount}{else/}-{/if}</div>
                            </div>
                        </div>
                        {/foreach}

                        {else/}
                            No Bid History!
                        {/if}
                </div>
                <div role="tabpanel" class="tab-pane" id="rate-history_tab">
                    {if $ratings.length > 0}
                        <div class="bhis-box">
                            <div class="row">
                               <div class="col-12"><span class="float-left font-weight-bold">Average Ratings: &nbsp;</span> {* <span class="float-left">{$average_rating}</span>&nbsp; *}<div style="" class="rateit" data-rateit-value="{$average_rating}" data-rateit-resetable="true" data-rateit-ispreset="true" data-rateit-mode="font" id="resett0" data-rateit-readonly="true"></div></div>
                               
                            </div>
                        </div>

                    {foreach $ratings as $key => $val}
                        <div class="bhis-box">
                            <div class="row">
                               <div class="col-4"><span class="float-left font-weight-bold">Buyer: &nbsp;</span> {$val.buyer_name}</div>
                               <div class="col-8"><span class="float-left font-weight-bold">Rate: &nbsp;</span> <div class="rateit" data-rateit-value="{$val.rate}" data-rateit-resetable="true" data-rateit-ispreset="true" data-rateit-mode="font" id="resett{$val.rate}" data-rateit-readonly="true"></div> </div>
                            </div>
                            <div class="row">
                               <div class="col-12 pt-2">{$val.comment}</div>
                            </div>
                        </div>
                    {/foreach}
                    {else/}
                        No Ratings found!
                    {/if}
                </div>
            </div>
        </div>
    </div>
</div>
{if $similarProduct.length}
<div class="search-content-wrap">
    <div class="container spl-wrap">
        <h2 class="bids-head">SIMILAR AUCTIONS</h2>
        <div class="owl-auctions owl-carousel owl-theme">
                {foreach $similarProduct as $key => $val}
                    <div class="item" style="width:auto">
                        <div class="card">
                            {if !$val.avatar}
                                <img class="card-img-top" src="{$config.url}/no_image.png" alt="No Image Available" onerror="this.onerror=null;this.src='/no_image.png';" style="width: 250px; height: 200px;" />
                            {else/}
                                <img class="card-img-top" src="{$config.url}/uploads/product/{$val.avatar}" alt="No Image Available" onerror="this.onerror=null;this.src='/no_image.png';" style="width: 250px; height: 200px;" />
                            {/if}
                            <div class="card-block">
                                <h4 class="card-title">{$val.title}</h4>
                                <p class="mb-1">Target Price : {if $loged.userid}${$val.reserve_price}{else/}-{/if}</p>
                                <p class="mb-1">Quantity Requested : {if $loged.userid}{$val.lots_available} {$val.unit_of_measurement}{else/}-{/if}</p>
                                <div class="timer-txt" id="mysimilar{$val.id}">03D:01H:2M:10S</div>
                                <a href="{$config.url}/product/view/{$val.id}" class="btn btn-brown">Bid Now</a>
                            </div>
                            <div class="upcoming">Similar</div>
                        </div>
                        {include file="time-loader-similar.tpl" nocache}
                    </div>
                {/foreach} 
            </div>
    </div>
</div>
<br>
<br>
{/if}

<script>
       $(document).ready(function (e) {
           console.log('called1')
            $(document).keypress(function (e) {
                if (e.which == 13) {
                    console.log('called')
                    if ($("#bid-success").css("display") == "block") {
                        $("#bid-success").modal('hide')
                    }
                }
            });
        });
    
</script>
<div class="modal fade hb-modal" id="bid-success" data-backdrop="static" data-keyboard="false">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <img src="{$config.url}/images/logo.png" class="m-auto" />
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    <i class="fa fa-times-circle"></i>
                </button>
            </div>
            <div class="modal-body"> 
                <h4 class="text-center">YOUR BID HAS BEEN SUCCESSFULLY PLACED</h4>
                <div class="lsc-msg">
                    <img src="{$config.url}/images/auction.png" alt="user">
                </div>
                <div class="ss-txt">BID AMOUNT</div>
                <div class="ss-txt1">
                    ${$previewData.start_price}
                </div>
                <button class="btn btn-prev" data-dismiss="modal">
                    THANK YOU
                </button>
            </div>
        </div>
    </div>
</div> 

<div class="modal fade hb-modal" id="confirm-msg" data-backdrop="static" data-keyboard="false">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <img src="{$config.url}/images/logo.png" class="m-auto" />
                <h4 class="modal-title"></h4>
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true" onclick="resetConfirm()">
                    <i class="fa fa-times-circle"></i>
                </button>
            </div>
            <div class="modal-body">
                <div class="text-center">
                    <div class="cus-check form-group d-inline-block">
                        <input type="checkbox" id="bid_check" name="type_auction" class="typeCheckbox" value="confirmedValue">
                        <span class="checkmark"></span> <label for="auction_check">Are you sure, you want to place bid?</label>
                    </div>
                </div> 
                
                <button class="btn btn-prev" id="submitBidBtn" disabled>
                    Yes!
                </button>
                <div class="text-center">*Please Note, you are bidding on entire quantity of this post.</div>

            </div>
        </div>
    </div>
</div>




<div class="modal fade hb-modal" id="modal-buynow" data-backdrop="static" data-keyboard="false">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <img src="{$config.url}/images/logo.png" class="m-auto" />
                <h4 class="modal-title"></h4>
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true" onclick="resetConfirm()" id="close_buynow">
                    <i class="fa fa-times-circle"></i>
                </button>
            </div>
            <div class="modal-body">
                <form action="{$config.url}/product/buyProduct" method="POST" id="BuyForm">
                <div class="form-group" style="margin-left: 0%;">
                    <label style="font-weight: bold;">Please Enter Qty :</label>
                    
                    <input name="id" class="form-control" value="{$projects.id}" hidden required>

                    <input type="number" min="{$projects.moq}" id="modal-buynow-input" name="buyQty" class="form-control" value="" onblur="validateBuyNow(this.value)" onkeyup="validateBuyNow(this.value)" required>

                    <div style="display: none; color:red" id="errMsgBuyNow">Please Enter {$projects.moq} or more</div>
                </div>
                <!-- <div class="ss-txt cus-check"><input type="checkbox" id="confirmationChk" class="typeCheckbox"/></div> -->
                <div class="row" style="width:100%;max-width: 328px; text-align: center; margin: auto;">
                    <button type="button" class="btn btn-secondary" onclick="$('#close_buynow').trigger('click')" style="width: 152px; height: 44px; margin: 0 auto 25px; display: block; font-size: 15px; font-weight: 600;">Cancel</button>
                    <button type="button" class="btn btn-prev" id="submitBuyBtn" onclick="submitBuyForm()" disabled>Buy!</button>
                </div>
                </form>
            </div>
        </div>
    </div>
</div>


<div class="modal fade hb-modal" id="common-msg" data-backdrop="static" data-keyboard="false">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <img src="{$config.url}/images/logo.png" class="m-auto" />
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    <i class="fa fa-times-circle"></i>
                </button>
            </div>
            <div class="modal-body"> 
                
                <h4 class="text-center" id="common-msg-title"></h4>
                <div class="ss-txt" id="common-msg-desc"></div>
                <button class="btn btn-prev" data-dismiss="modal">
                    Okay!
                </button>
            </div>
        </div>
    </div>
</div>

<div class="modal fade hb-modal" id="offer_chat_popup" data-backdrop="static" data-keyboard="false">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <img src="{$config.url}/images/logo.png" class="m-auto" />
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    <i class="fa fa-times-circle"></i>
                </button>
            </div>
            <div class="modal-body">  
                <h4 class="text-center" id="common-msg-title">Chat with Seller</h4>
                <div class="" id="offer_chat_list">
                    <i class="fa fa-spinner fa-spin"></i>
                </div>
                <div id="offer_message_send_div" style="display: none;">
                    <div class="form-group">
                        <textarea name="chat_message" id="chat_message" class="form-control float-left" value="" required rows="1"></textarea>
                    </div>
                    <div class="form-group">
                        <button class="btn btn-prev float-right m-0" id="send_chat_message" onclick="send_chat_message()">Send</button>
                    </div>
                </div>
                <div id="offer_submit_div" style="display: none;">
                    <div class="text-secondary"><i><b>Note:</b></i> Please submit offer amount for the quantity offered to start chat with seller.</div>
                    <div class="">
                        <input type="text" class="form-control float-left col-sm-9 onlyNumber" name="offer_amount" id="offer_amount" value="" style="border-radius: 0px;">
                        <button type="button" class="btn btn-prev float-left m-0" name="submit_offer" id="submit_offer" style="height: 38px;">Submit</button>
                    </div>
                </div>
                {* <button class="btn btn-prev" data-dismiss="modal">
                    Send
                </button> *}
                <div class="mt-3 float-left">
                    <p class="p-0" style="text-align: justify; color: red;">
                        <b>Note: </b></b>Please do <b>NOT</b> share any of your contact information. This includes name, phone, URLs, social media etc. We scan and analyze messages to identify potential fraud and policy violations. Failure to follow policies may trigger the termination of your membership to HempBuyerAuction. If you need additional assistance with correspondence/questions, please email support@hempbuyer.com. Be sure to include the item id you are referring to. We are here to help and support you in your success.
                    </p>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- / page content  -->

<section class="search-content-wrap og-auc-wrap">
    <div class="container spl-wrap">
        <h2 class="on-ahead">ADVERTISEMENTS</h2>
        <div id="ads_list1"></div>
    </div>
</section>


{include file="/common/footer-1.tpl" nocache}

<script language="javascript" type="text/javascript">
    storedData = [];
    certificates = [];
    productDocument = [];


    var localData = localStorage.getItem('drafedData');
    if (localData) {
        localData = JSON.parse(localData);
        storedData = localData;

        /* var index = storedData.findIndex(function(item){ return item.id=='description'})
        if(index>-1) { $("#description").html(storedData[index].value);}

        var index = storedData.findIndex(function(item){ return item.id=='title'})
        if(index>-1) { $(".pv-title").html(storedData[index].value);} */
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

        var end_date = $('#countdown_timer').attr('data-enddate');
        end_date = new Date(end_date);
        $('#countdown_timer').countdown(end_date, { elapse: false })
            .on('update.countdown', function (event) {
                var $this = $(this);
                /* if (event.elapsed) {
                    $this.html(event.strftime('%DD : %HH : %MM : %SS'));
                } else { */
                $this.html(event.strftime('%DD : %HH : %MM : %SS'));
                // }
            })
            .on('finish.countdown', function (event) {
                $(this).html('Closed').addClass('text-red');
                if($(".bidder_status").html() == 'You are the higher bidder' && +'{$previewData.reserve_price}' <= +'{$previewData.win_price}') {
                    $(".bidder_status").html() = "Congratulations you have been won this product";
                } else {
                    $(".bidder_status").html() = "You lost this product";
                }
            });
    });
    console.log('asd', $(".bidder_status").html());

</script>

<script>

$("#bid_check").change(function() {
    if(this.checked) {
        $('#submitBidBtn').removeAttr('disabled');
    }else{
        $('#submitBidBtn').attr('disabled', true);
    }
});

$("#submitBidBtn").click(function() {

    $('#confirm-msg').trigger('click');
    $('#confirm-msg').modal('hide');
    var pid = '{$projects["id"]}';
    
    // if($('#my' + pid).html != 'Closed')
    // {
    //     return;
    // }

    if(parseInt($('#bidInput').val()) < parseInt($('#next_bid_amount').html())){
        $('#common-msg-title').html('')
        $('#common-msg-desc').html('Please Enter Valid Amount!')
        $('#common-msg').modal();
        return;
    }


    $.ajax({
        type: 'POST',
        url: '/product/placeBid',
        data: {
          id: pid,
          testbid_incre: 1,
          next_bid: "",
          enteramount:$('#bidInput').val()
        },
        dataType: 'json',
        cache: false,
        success: function (data) {
            if(data.status == 'login_error'){
                window.location.replace('/signin')
            }
          return false;
        }
      });
});
</script>


<script>

socket.on('disableBid', function (msg) {
    console.log('msg', '{$projects.id}', msg);
    if('{$projects.id}' == msg.projectId) {
        $('#submitBidBtnView').attr('disabled','disabled');
        $('#submitBidBtnView').hide();
        $('#submitBidBtn').attr('disabled','disabled');
        $('#bid_check').attr('disabled','disabled');
        $('#bid_amount_div').hide();
        $("#lots_available").html(msg.lots_available);
    }
});

socket.on('product_renewed', function (msg) {
    console.log('product_renewed', msg);
    if('{$projects.id}' == msg.product_id) {
        window.location.reload();
    }
});

var userId = 1;
socket.on('bidMessage', function (msg) {
    if('{$projects.id}' == msg.id) {
        console.log('msg', msg);
        if(+'{$loged.userid}' > 0) {
            if(+'{$loged.userid}' == msg.bpop_cbidder) {
                $(".bidder_status").html("You are the higher bidder");
                $(".bidder_status").removeClass("text-danger").addClass("text-success");
            } else {
                $(".bidder_status").html("You have been out bidded");
                $(".bidder_status").removeClass("text-success").addClass("text-danger");
            }
            $(".bidder_status").show();
        }
        $('#bid_check').prop("checked", false);
        $('#submitBidBtn').attr('disabled', true);

        var currentUser = '${currentUser}'
        if(currentUser == msg.bpop_cbidder){
            if(msg.status == 'failed'){
                if(msg.bpop_error == 'winbid_restriction'){
                    $('#common-msg-title').html('')
                    $('#common-msg-desc').html(msg.message)
                    $('#common-msg').modal();
                }
            }else{
                if(msg.bpop_error == 'winbid_success'){
                    $('#common-msg-title').html('')
                    $('#common-msg-desc').html(msg.message)
                    $('#common-msg').modal();
                }
            }
        }

        $('#next_bid_amount').html(msg.next_bid_amount);
        $('#last_bid').html(msg.last_bid);

        var template = '';

        $('#total_bid').html(msg.bidHistory[0].totalBid)
        for(var i = 0; i< msg.bidHistory.length; i++){
            val = msg.bidHistory[i];
            console.log(val);

            template += `<div class="bhis-box">
                                <div class="row">
                                <div class="col-2">User Name :`+ val['username'] +`</div>
                                <div class="col-2">Location : `+val.state+`</div>
                                <div class="col-2">` + val.created_at +`</div>
                                <div class="col-2">No of Bids : `+val.bidCount+`</div>
                                <div class="col-2 pp-txt">BID AMOUNT : $`+val.proposed_amount+`</div>
                                </div>
                            </div>`
        }
        
        
        if( msg.bidHistory.length > 0)
            $('#bid-history_tab').html(template);
    }
});


function resetConfirm(){
    $('#bid_check').prop('checked',false); $('#submitBidBtn').attr('disabled',true)
}


function validateValues(){

    if($('#my' + '{$projects["id"]}').html() == 'Closed')
    {
        $('#common-msg-title').html('')
        $('#common-msg-desc').html('Auction Closed!')
        $('#common-msg').modal();
        return;
      
    } 

    if($('#bidInput').val().length > 0){
        $('#confirm-msg').modal();
        $('#errMsg').hide();
    }else{
        $('#errMsg').show();
    }
}

function buyNowProduct(){

    if($('#my' + '{$projects["id"]}').html() == 'Closed')
    {
        $('#common-msg-title').html('')
        $('#common-msg-desc').html('Auction Closed!')
        $('#common-msg').modal();
        return;
      
    }   

    $("#modal-buynow-input").val("");
    $('#modal-buynow').modal();
    setTimeout(function(){
        $("#modal-buynow-input").focus();
    }, 500);

}
function buyNowProductOffer(){

    if($('#my' + '{$projects["id"]}').html() == 'Closed')
    {
        $('#common-msg-title').html('')
        $('#common-msg-desc').html('Auction Closed!')
        $('#common-msg').modal();
        return;
      
    }

    $("#modal-buynow-input").val("{$projects.offer_qty}");
    $('#submitBuyBtn').removeAttr('disabled');
    submitBuyForm();
}


function validateBuyNow(value){

    
    var moq = '{$projects.moq}';
    if(+(moq) > +(value)){
        $('#errMsgBuyNow').show();
        $('#submitBuyBtn').attr('disabled','disabled');
    }else{
        $('#errMsgBuyNow').hide();
        $('#submitBuyBtn').removeAttr('disabled');
    }
}

function submitBuyForm(){
    
    $('#modal-buynow').trigger('click');
    $('#modal-buynow').modal('hide');

    $.ajax({
        type: 'POST',
        url: '/product/buyProduct',
        dataType: 'json',
        cache: false,
        data : $('#BuyForm').serialize(),
        success: function (data) {
            if(data.status == 'buy_error'){
                $('#common-msg-title').html('')
                $('#common-msg-desc').html('Entered Qty is not available.')
                $('#common-msg').modal();
                $('#modal-buynow-input').val('')
                return;
            }else{
                /* $('#common-msg-title').html('')
                $('#common-msg-desc').html('Item purchased success.')
                $('#common-msg').modal();
                $('#modal-buynow-input').val('')
                $("#lots_available").html(data.lots_available);
                console.log('asd', +data.lots_available < +'{$previewData.offer_qty}', +data.lots_available, +'{$previewData.offer_qty}');
                if(+data.lots_available < +'{$previewData.offer_qty}') {
                    $("#buyNowOfferBtn").attr("disabled", "disabled");
                }
                setTimeout(function() {
                    window.location.reload()
                }, 5000); */
                window.location.href="/buyer/buyAuction"
                return;
            }
          return false;
        }
      });
}

getAds();
function getAds() {
    var Obj = {
        page: 'product_view'
    };
    $.ajax({
        type: "POST",
        url: "{$config.url}/get_ads",
        data: Obj,
        success: function (data) {
            $("#ads_list").html(data);
            $("#ads_list1").html(data);
        }
    });
}

socket.on('offer_message', function (data) {
    if(+'{$projects.id}' == +data.product_id && (+'{$loged.userid}' == +data.receiver_id || +'{$loged.userid}' == +data.sender_id)) {
        console.log('data', data);
        $(".chat_other_div").remove();
        var message = data.message.replace(/([^>\r\n]?)(\r\n|\n\r|\r|\n)/g, '<br>');
        var html = '<div class="chat_item">'
                +'<div class="'+(data.sender_id=='{$loged.userid}' ? 'sent' : 'received') +'">'+message
                +'<span class="text-secondary float-right font-italic mt-2">'+data.created_date+'</span></div>'
            +'</div>';
        $("#offer_chat_list").append(html);
        var offset = $("#offer_chat_list").offset().top * 100;
        $('#offer_chat_list').animate({
            scrollTop: offset
        }, 1000);
        if(!$("#offer_chat_popup").hasClass("show")) {
            var unread = +$(".unread_count").html();
            if(unread) {
                $(".unread_count").html(unread+1);
            } else {
                $(".unread_count").html(1);
            }
            $(".unread_count").show();
        }
    }
});
socket.on('offer_buynow_activated_'+'{$projects.id}_{$loged.userid}', function (data) {
    console.log('offer_buynow_activated_ ', data);
    $("#buyNowOfferBtn").attr('disabled', false);
    $("#offer_price_div").html("$"+data.amount);
});
socket.on('end_date_change', function (data) {
    console.log('end_date_change', data);
    if(+'{$projects.id}' == +data.product_id) {
        $("#my{$projects.id}").attr('data-enddate', data.end_date);
        window.location.reload();
    }
});

function offerContactSellerChat() {
    $("#offer_chat_popup").modal("show");
    $(".unread_count").html("0");
    $(".unread_count").hide();
    var loader = '<i class="fa fa-spinner fa-spin"></i>';

    var Obj = {
        product_id: '{$projects.id}'
    };
    $.ajax({
        type: "POST",
        url: "{$config.url}/product/get_offer_chats",
        data: Obj,
        success: function (data) {

            $("#offer_chat_list").html(data);
            setTimeout(function() {
                var totalMessages = +$("#chat_length").val();
                console.log('totalMessages', totalMessages);
                if(totalMessages < 1 && '{$previewData.type}' == 'offer') {
                    $("#offer_message_send_div").hide();
                    $("#offer_chat_list").hide();
                    $("#offer_submit_div").show();
                    $("#offer_amount").focus();
                } else {
                    $("#offer_submit_div").hide();
                    $("#offer_message_send_div").show();
                    $("#offer_chat_list").show();
                    $("#chat_message").focus();
                }
                $('#offer_chat_list').animate({
                    scrollTop: $("#offer_chat_list").offset().top * 100
                }, 0);
            }, 100);
        }
    });
}
function send_chat_message() {
    // $("#offer_chat_popup").modal("show");
    var message = $("#chat_message").val();
    if(message.trim() == '') {
        $("#chat_message").focus();
        return true;
    }
    var buyer_offer = +$("#offer_amount").val();
    if(buyer_offer > 0) {
        $("#offer_amount").val("");
    }
    var Obj = {
        product_id: '{$projects.id}',
        seller_id: '{$projects.user_id}',
        sender_id: '{$loged.userid}',
        receiver_id: '{$projects.user_id}',
        message: message,
        buyer_offer: buyer_offer
    };
    console.log("Obj-------------=--=-=-=-=-==-")
    console.log(Obj)
    $.ajax({
        type: "POST",
        url: "{$config.url}/product/send_offer_message",
        data: Obj,
        success: function (data) {
            if(data.success) {
                $("#chat_message").val("");
                $("#offer_submit_div").hide();
                $("#offer_message_send_div").show();
                $("#offer_chat_list").show();
            }
        }
    });
}

$(document).ready(function(){
    if('{$chat_popup}' != '') {
        $("#open-offered-messages_{$chat_popup}").trigger('click');
    }

    $(document).on('keypress', '.onlyNumber', function(evt) {
        var charCode = (evt.which) ? evt.which : evt.keyCode;
        if (charCode != 46 && charCode > 31
        && (charCode < 48 || charCode > 57))
            return false;

        return true;
    });
    $(document).on('keypress', '#offer_amount', function(e) {
        var keycode = (e.keyCode ? e.keyCode : e.which);
        if(keycode == '13'){
            $("#submit_offer").trigger("click");
        }
    });
    $(document).on('click', '#submit_offer', function() {
        var amount = $("#offer_amount").val();
        if(amount.trim() == "" || +amount.trim() < 1) {
            $("#offer_amount").focus();
            return true;
        }
        var msg = "Hi, I'm offering you $"+amount+" for this auction";
        $("#chat_message").val(msg);
        send_chat_message();

    });
    $(document).on('keydown', '#chat_message', function(e) {
        if (e.ctrlKey && e.keyCode == 13) {
            // Ctrl-Enter pressed
            send_chat_message();
        }
    });
    $(document).on('click', '.nav-link', function(e) {
        if($(this).attr("id") == 'rate_history') {
            setTimeout(function() {
                $('.rateit').rateit('reset');
            });
        }
    });
    
});
</script>
{include file="time-loader.tpl" nocache}