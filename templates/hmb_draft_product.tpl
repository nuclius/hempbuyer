{include file="/common/header-1.tpl" nocache}

<!-- <div class="clearfix auth-container" style="padding-top: 100px !important;"> -->
<section class="db-wrapper db-iwrap">
    {include file="/common/header-2.tpl" nocache}
    <div class="container">
        <div class="row">
            <div class="col-sm-6">
                <h3 class="acc-head">
                    MY AUCTION (DRAFTS)
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
                    <li><a href='/seller/draftAuction' class="active">Drafts</a></li>
                    <li><a href='/seller/closedAuction' class="">Closed Auctions</a></li> 
                </ul>
            </div>
            <div class="db-right-con">
                <form action="{$config.url}/seller/draftAuction" method="post">
                    <div id="draftProductSection">              
                        {include file="hmb_draft_product_template.tpl" nocache}
                    </div>
                </form>
            </div>
         </div>
    </div>
</section>

<div class="modal fade hb-modal" id="draft-product-bid-history-modal">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <img src="{$config.url}/images/logo.png" class="m-auto" />
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    <i class="fa fa-times-circle"></i>
                </button>
            </div>
            <div class="modal-body bid-history-wrap"> 
                
                <h4 class="text-center">BID HISTORY</h4> 
                <table class="table table-hover">
                    <thead>
                        <tr>
                            <th>User Name</th>
                            <th>Date & Time</th>
                            <th>Amount</th>
                        </tr>
                    </thead>
                    <tbody id="draft-product-bid-history-list">
                    </tbody>
                </table>
            </div> 
        </div>
    </div>
</div>
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
        $('body').on('click', '.draft-product-bid-history', function() {
            var id = $(this).attr('data-id');
            var html = '';
            $('#draft-product-bid-history-modal #draft-product-bid-history-list').html('');
            if(id && id != "" && id != 0) {
                $.ajax({
                    type : 'POST',
                    url  : '/getDetailBidHistory',
                    data : { id : id },
                    dataType : 'json',
                    success  : function(data) {
                        if(data.data.length > 0) {
                            $.each(data.data, function(i, v) {
                                html += '<tr>';
                                html += '<td>'+v.name.substr(0, 1)+'***'+v.name.substr(v.name.length - 1)+'</td>';
                                html += '<td>'+v.bidPlacedAt+'</td>';
                                html += '<td>$'+parseFloat(v.amount).toFixed(2)+'</td>';
                                html += '</tr>';
                            });
                        } else
                            html = '<tr class="text-center"><td colspan="3" class="text-center no-bids"><h5 class="text-center">There is no bid.</h5></td></tr>';

                        $('#draft-product-bid-history-modal #draft-product-bid-history-list').html(html);
                        $('#draft-product-bid-history-modal').modal('show');
                    }
                });
            } else {
                html = '<tr class="text-center"><td colspan="3" class="text-center no-bids"><h5 class="text-center">There is no bid.</h5></td></tr>';
                $('#draft-product-bid-history-modal #draft-product-bid-history-list').html(html);
            }
        });

        searchForm();
    });

    $('body').on('change', '#sort_by', function() {
        searchForm();
    });

    function searchForm() {
        $('#draftProductSection').html('');
        $.ajax({
            type : 'POST',
            url  : '/searchAuctionPage',
            data :  { page : $('#page').val(), status : "'draft'", sort_by : $('#sort_by').val() },
            dataType : 'json',
            success  : function(data) {
                $('#sort_by').val($('#sort_by').val());
                $('input[name="page"]').val(1);
                $('#draftProductSection').html(data.html);
            }
        });
    }
</script>