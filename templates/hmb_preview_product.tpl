{include file="/common/header-1.tpl" nocache}
<!-- page content  -->
<style>
</style>

<div class="search-container profile-container">
    {* <div class="pc-breadcrumb">
        <div class="container">
            <div class="float-left">
                Search > {$previewData.title}
            </div>
        </div>
    </div> *}
    <div class="container">
        <div class="media pv-media" style="margin: 0px;">
            <div class="media-left">
                <div id="slider" class="flexslider">
                    <ul class="slides">
                        {foreach $previewData.productDocument as $key => $val}
                        <li>
                            {if $val.fileType=='video'}
                                <video style="width:100%;" controls>
                                    <source src="{$config.url}/uploads/product/{$val.name}" type="{$val.mimetype}">
                                </video>
                            {else /}
                                <img src="{$config.url}/uploads/product/{$val.name}" alt="{$val.originalname}" />
                            {/if}
                        </li>
                        {/foreach}
                    </ul>
                </div>
                <div id="carousel" class="flexslider">
                    <ul class="slides">
                        {foreach $previewData.productDocument as $key => $val}
                        <li>
                            {if $val.fileType=='video'}
                                <video src="{$config.url}/uploads/product/{$val.name}" type="{$val.mimetype}">
                            {else /}
                                <img src="{$config.url}/uploads/product/{$val.name}" alt="{$val.originalname}" />
                            {/if}
                        </li>
                        {/foreach}
                    </ul>
                </div>
            </div>
            <div class="media-body">
                <h3 class="pv-title">
                    {$previewData.title}
                </h3>
                <div class="pv-timer1" id="countdown_timer" data-enddate="{$previewData.end_date}">06D : 08H : 05M : 03S
                </div>
                {if $previewData.type == 'fixed'}
                    <div class="pv-con">
                        Fixed Price : ${$previewData.fixed_price}
                    </div>
                    <div class="pv-con">
                        Fixed Qty : {$previewData.fixed_qty} {if $previewData.unit_of_measurement!='' and $previewData.unit_of_measurement!='0'} {$previewData.unit_of_measurement} {/if}
                    </div>
                    <div class="pv-con">
                        Available Qty : {$previewData.amount_sold} {if $previewData.unit_of_measurement!='' and $previewData.unit_of_measurement!='0'} {$previewData.unit_of_measurement} {/if}
                    </div>
                {/if}
                {if $previewData.type == 'offer'}
                    <div class="pv-con">
                        Offer Price : ${$previewData.offer_price}
                    </div>
                    <div class="pv-con">
                        Offer Qty : {$previewData.offer_qty} {if $previewData.unit_of_measurement!='' and $previewData.unit_of_measurement!='0'} {$previewData.unit_of_measurement} {/if}
                    </div>
                    <div class="pv-con">
                        Available Qty : {$previewData.amount_sold} {if $previewData.unit_of_measurement!='' and $previewData.unit_of_measurement!='0'} {$previewData.unit_of_measurement} {/if}
                    </div>
                {/if}
                {if $previewData.type == 'auction'}
                    <div class="pv-con">
                        Start Bid : ${$previewData.start_price}
                    </div>
                    <div class="pv-con">
                        Total Bids : 0
                    </div>
                    <div class="pv-con">
                        Current Bid : $0.00
                    </div>
                {/if}
                {if $previewData.type == 'auction' && $previewData.is_buynow}
                    <div class="pv-con">
                        Buy Now Price : ${$previewData.buynow_price} {if $previewData.unit_of_measurement!='' and $previewData.unit_of_measurement!='0'} per {$previewData.unit_of_measurement} {/if}
                    </div>
                    <div class="pv-con">
                        Minimum Qty : {$previewData.moq} {if $previewData.unit_of_measurement!='' and $previewData.unit_of_measurement!='0'} {$previewData.unit_of_measurement} {/if}
                    </div>
                {/if}
                <div class="row sb-wrap">
                    {if $previewData.type == 'auction'}
                        <div class="col-12">
                            <input class="form-control" placeholder="Enter Amount $">
                            <div class="pv-note">Enter US ${$previewData.start_price} or more</div>
                        </div>
                        <div class="col-12">
                            <button class="btn btn-brown" type="button" data-toggle="modal" data-target="#bid-success" disabled>
                                SUBMIT BID
                            </button>
                        </div>
                    {/if}
                    <div class="col-12 mt-3">
                        <button class="btn btn-brown" type="button" data-toggle="modal" data-target="#bid-success" disabled>
                            Buy Now
                        </button>
                    </div>
                </div>
            </div>
        </div>
        <div class="bids-container">
            <ul class="nav nav-tabs">
                <li class="nav-item">
                    <a href="#description" data-toggle="tab" class="nav-link active">
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
                <!-- <li class="nav-item">
                    <a href="#bid-history" data-toggle="tab" class="nav-link">BID HISTORY</a>
                </li> -->
                <li class="nav-item">
                    <a href="#rate-history_tab" data-toggle="tab" class="nav-link" id="rate_history">RATINGS</a>
                </li>
            </ul>
            <div class="tab-content">
                <div role="tabpanel" class="tab-pane active" id="description">
                    <p>
                        {$previewData.description}
                    </p>
                </div>
                <div role="tabpanel" class="tab-pane" id="bid-history">
                    <div class="bhis-box">
                        <div class="row">
                            <div class="col-12">There is no bids.</div>
                        </div>
                    </div>
                </div>
                <div role="tabpanel" class="tab-pane" id="attributes_tab">
                    <div class="d-inline-block">
                        {if $previewData.ctype_certified_organic == 'true'}
                        <div class="form-group toggle_checkbox_div">
                            <input type="checkbox" checked disabled>
                            <label for="ctype_certified_organic" class="toggle_checkbox">Certified Organic</label>
                        </div>
                         {/if}
                        {if $previewData.ctype_gmp == 'true'}
                        <div class="form-group toggle_checkbox_div">
                            <input type="checkbox" checked disabled>
                            <label for="ctype_certified_organic" class="toggle_checkbox">GMP</label>
                        </div>
                         {/if}
                        {if $previewData.ctype_iso == 'true'}
                        <div class="form-group toggle_checkbox_div">
                            <input type="checkbox" checked disabled>
                            <label for="ctype_certified_organic" class="toggle_checkbox">ISO</label>
                        </div>
                        {/if}
                        {if $previewData.ctype_kosher == 'true'}
                        <div class="form-group toggle_checkbox_div">
                            <input type="checkbox" checked disabled>
                            <label for="ctype_certified_organic" class="toggle_checkbox">Kosher</label>
                        </div>
                        {/if}
                        {if $previewData.ctype_sqf == 'true'}
                        <div class="form-group toggle_checkbox_div">
                            <input type="checkbox" checked disabled>
                            <label for="ctype_certified_organic" class="toggle_checkbox">SQF</label>
                        </div>
                        {/if}
                        {if $previewData.ctype_fda_registered == 'true'}
                        <div class="form-group toggle_checkbox_div">
                            <input type="checkbox" checked disabled>
                            <label for="ctype_certified_organic" class="toggle_checkbox">FDA Registered</label>
                        </div>
                        {/if}
                        {if $previewData.ctype_outdoor == 'true'}
                        <div class="form-group toggle_checkbox_div">
                            <input type="checkbox" checked disabled>
                            <label for="ctype_certified_organic" class="toggle_checkbox">Outdoor</label>
                        </div>
                        {/if}
                        {if $previewData.ctype_indoor == 'true'}
                        <div class="form-group toggle_checkbox_div">
                            <input type="checkbox" checked disabled>
                            <label for="ctype_certified_organic" class="toggle_checkbox">Indoor</label>
                        </div>
                        {/if}
                        {if $previewData.ctype_greenhouse == 'true'}
                        <div class="form-group toggle_checkbox_div">
                            <input type="checkbox" checked disabled>
                            <label for="ctype_certified_organic" class="toggle_checkbox">Greenhouse</label>
                        </div>
                        {/if}
                        {if $previewData.ctype_light_deprivation == 'true'}
                        <div class="form-group toggle_checkbox_div">
                            <input type="checkbox" checked disabled>
                            <label for="ctype_certified_organic" class="toggle_checkbox">Light Deprivation</label>
                        </div>
                        {/if}
                        {if $previewData.ctype_co2 == 'true'}
                        <div class="form-group toggle_checkbox_div">
                            <input type="checkbox" checked disabled>
                            <label for="ctype_certified_organic" class="toggle_checkbox">CO2</label>
                        </div>
                        {/if}
                        {if $previewData.ctype_ethanol == 'true'}
                        <div class="form-group toggle_checkbox_div">
                            <input type="checkbox" checked disabled>
                            <label for="ctype_certified_organic" class="toggle_checkbox">Ethanol</label>
                        </div>
                        {/if}
                        {if $previewData.ctype_hydrocarbon_extraction == 'true'}
                        <div class="form-group toggle_checkbox_div">
                            <input type="checkbox" checked disabled>
                            <label for="ctype_certified_organic" class="toggle_checkbox">Hydrocarbon Extraction</label>
                        </div>
                        {/if}
                        {if $previewData.ctype_statement_of_origin_available == 'true'}
                        <div class="form-group toggle_checkbox_div">
                            <input type="checkbox" checked disabled>
                            <label for="ctype_certified_organic" class="toggle_checkbox">Statement of origin available</label>
                        </div>
                        {/if}
                        {if $previewData.ctype_statement_of_compliance_available == 'true'}
                        <div class="form-group toggle_checkbox_div">
                            <input type="checkbox" checked disabled>
                            <label for="ctype_certified_organic" class="toggle_checkbox">Statement of compliance available</label>
                        </div>
                        {/if}
                    </div>
                </div>
                <div role="tabpanel" class="tab-pane" id="documents_tab">
                    <p class="">
                        <b>Date of Certificate of Analysis:</b> {$previewData.certificate_date}
                    </p>
                    <div class="d-block pb-3">
                        {foreach $previewData.certificateDocument as $key => $val}
                            <div class="image-item" id="doc_{$key+1}">
                                {$key+1}. <a href="{$config.url}/uploads/certificates/{$val.name}" target="_blank">{$val.name}</a>
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
<div class="search-content-wrap">
    <div class="container spl-wrap">
        <h2 class="bids-head">SIMILAR AUCTIONS</h2>
        <div>
            Similar Auction List
        </div>
    </div>
</div>
<br>
<br>
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
<!-- / page content  -->
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

            });
    });

</script>