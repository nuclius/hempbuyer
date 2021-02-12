{include file="/common/header-1.tpl" nocache}

<!-- <div class="clearfix auth-container" style="padding-top: 100px !important;"> -->
<section class="db-wrapper db-iwrap">
    {include file="/common/header-2.tpl" nocache}
    <div class="container">
        <div class="row">
            <div class="col-sm-6">
                <h3 class="acc-head">
                    MY AUCTION (POSTED PRODUCTS)
                </h3>
            </div>
            <div class="col-sm-6">
                <div class="form-inline wt-wrap">
                    <div class="clearfix cselec-wrap sort-by">
                        <select class="custom-select">
                            <option>Sort By</option>
                        </select>
                    </div> 
                </div>
            </div>
        </div>
         <div class="db-content">
            <div class="db-menu">
                <ul class="">
                    <li><a class="active">Posted Products</a></li>
                    <li><a>Products Sold</a></li>
                    <li><a>Drafts</a></li>
                    <li><a>Completed Auctions</a></li> 
                </ul>
            </div>
            <div class="db-right-con">
                {foreach $products as $key => $val}
                    <div class="media mauc-media">
                        <div class="media-left" style="width: 200px;">
                            <!-- <img src="images/pro8.png" alt="" /> -->
                            <img src="./uploads/product/{$val.avatar}" alt="No Image Available" onerror="this.onerror=null;this.src='./no_image.png';" />
                        </div>
                        <div class="media-body">
                            <div class="row">
                                <div class="col-md-7">
                                    <h3 class="pro-title">
                                        {$val.title}
                                    </h3>
                                    <div class="row">
                                        <div class="col-sm-6 pro-con">
                                            <img src="images/return.png" /> Start Price : ${$val.start_price}
                                        </div>
                                        <div class="col-sm-6 pro-con">
                                            <img src="images/pauction.png" /> Sold : 00
                                        </div>
                                        <div class="col-sm-6 pro-con">
                                            <img src="images/total-quantity.png" /> Total Quantity : 01
                                        </div>
                                        <div class="col-sm-6 pro-con">
                                            <span class="bid-txt">BID</span> Total Bid : 00
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-5 text-center">
                                    <img src="/images/chronometer.png" class="m-auto cm-icon" />
                                    <div class="time-left">Time Left</div>
                                    <div class="timer timer-txt" id="my{$val.id}">Closed</div> 
                                    <button class="btn btn-prev" type="button" data-toggle="modal" data-target="#bid-history">
                                        BID HISTORY
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                {/foreach}

                {if $products.length <= '0'}
                    <div class="text-center not_found">No Product Found! </div>
                {/if}

                <nav class="text-right">
                     {$pagination_html}
                </nav>
            </div>

            <div style="display: none;">
                <div class="media mauc-media">
                    <div class="media-left">
                        <img src="images/pro8.png" alt="" />
                    </div>
                    <div class="media-body">
                        <div class="row">
                            <div class="col-md-7">
                                <h3 class="pro-title">
                                    Bulk CBD Full Spectrum Hemp Oil Concentrate
                                </h3>
                                <div class="row">
                                    <div class="col-md-6 pro-con">
                                        <img src="images/return.png" /> Start Price : $500.00
                                    </div>
                                    <div class="col-md-6 pro-con">
                                        <img src="images/pauction.png" /> Sold : 01
                                    </div>
                                    <div class="col-md-6 pro-con">
                                        <img src="images/total-quantity.png" /> Total Quantity : 01
                                    </div>
                                    <div class="col-md-6 pro-con">
                                        <span class="bid-txt">BID</span> Total Bid : 02
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-5 text-center">
                                <img src="/images/chronometer.png" class="m-auto cm-icon" />
                                <div class="time-left">Time Left</div>
                                <div class="timer">06D : 08H : 05M : 03S</div>
                                <button class="btn btn-prev" type="button" data-toggle="modal" data-target="#bid-history">
                                    BID HISTORY
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="media mauc-media">
                    <div class="media-left">
                        <img src="images/pro8.png" alt="" />
                    </div>
                    <div class="media-body">
                        <div class="row">
                            <div class="col-md-7">
                                <h3 class="pro-title">
                                    Bulk CBD Full Spectrum Hemp Oil Concentrate
                                </h3>
                                <div class="row">
                                    <div class="col-md-6 pro-con">
                                        <img src="images/return.png" /> Start Price : $500.00
                                    </div>
                                    <div class="col-md-6 pro-con">
                                        <img src="images/pauction.png" /> Sold : 01
                                    </div>
                                    <div class="col-md-6 pro-con">
                                        <img src="images/total-quantity.png" /> Total Quantity : 01
                                    </div>
                                    <div class="col-md-6 pro-con">
                                        <span class="bid-txt">BID</span> Total Bid : 02
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-5 text-center">
                                <img src="/images/chronometer.png" class="m-auto cm-icon" />
                                <div class="time-left">Time Left</div>
                                <div class="timer">06D : 08H : 05M : 03S</div>
                                <button class="btn btn-prev" type="button" data-toggle="modal" data-target="#bid-history">
                                    BID HISTORY
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="media mauc-media">
                    <div class="media-left">
                        <img src="images/pro8.png" alt="" />
                    </div>
                    <div class="media-body">
                        <div class="row">
                            <div class="col-md-7">
                                <h3 class="pro-title">
                                    Bulk CBD Full Spectrum Hemp Oil Concentrate
                                </h3>
                                <div class="row">
                                    <div class="col-md-6 pro-con">
                                        <img src="images/return.png" /> Start Price : $500.00
                                    </div>
                                    <div class="col-md-6 pro-con">
                                        <img src="images/pauction.png" /> Sold : 01
                                    </div>
                                    <div class="col-md-6 pro-con">
                                        <img src="images/total-quantity.png" /> Total Quantity : 01
                                    </div>
                                    <div class="col-md-6 pro-con">
                                        <span class="bid-txt">BID</span> Total Bid : 02
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-5 text-center">
                                <img src="/images/chronometer.png" class="m-auto cm-icon" />
                                <div class="time-left">Time Left</div>
                                <div class="timer">06D : 08H : 05M : 03S</div>
                                <button class="btn btn-prev" type="button" data-toggle="modal" data-target="#bid-history">
                                    BID HISTORY
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="media mauc-media">
                    <div class="media-left">
                        <img src="images/pro8.png" alt="" />
                    </div>
                    <div class="media-body">
                        <div class="row">
                            <div class="col-md-7">
                                <h3 class="pro-title">
                                    Bulk CBD Full Spectrum Hemp Oil Concentrate
                                </h3>
                                <div class="row">
                                    <div class="col-md-6 pro-con">
                                        <img src="images/return.png" /> Start Price : $500.00
                                    </div>
                                    <div class="col-md-6 pro-con">
                                        <img src="images/pauction.png" /> Sold : 01
                                    </div>
                                    <div class="col-md-6 pro-con">
                                        <img src="images/total-quantity.png" /> Total Quantity : 01
                                    </div>
                                    <div class="col-md-6 pro-con">
                                        <span class="bid-txt">BID</span> Total Bid : 02
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-5 text-center">
                                <img src="/images/chronometer.png" class="m-auto cm-icon" />
                                <div class="time-left">Time Left</div>
                                <div class="timer">06D : 08H : 05M : 03S</div>
                                <button class="btn btn-prev" type="button" data-toggle="modal" data-target="#bid-history">
                                    BID HISTORY
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="media mauc-media">
                    <div class="media-left">
                        <img src="images/pro8.png" alt="" />
                    </div>
                    <div class="media-body">
                        <div class="row">
                            <div class="col-md-7">
                                <h3 class="pro-title">
                                    Bulk CBD Full Spectrum Hemp Oil Concentrate
                                </h3>
                                <div class="row">
                                    <div class="col-md-6 pro-con">
                                        <img src="images/return.png" /> Start Price : $500.00
                                    </div>
                                    <div class="col-md-6 pro-con">
                                        <img src="images/pauction.png" /> Sold : 01
                                    </div>
                                    <div class="col-md-6 pro-con">
                                        <img src="images/total-quantity.png" /> Total Quantity : 01
                                    </div>
                                    <div class="col-md-6 pro-con">
                                        <span class="bid-txt">BID</span> Total Bid : 02
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-5 text-center">
                                <img src="/images/chronometer.png" class="m-auto cm-icon" />
                                <div class="time-left">Time Left</div>
                                <div class="timer">06D : 08H : 05M : 03S</div>
                                <button class="btn btn-prev" type="button" data-toggle="modal" data-target="#bid-history">
                                    BID HISTORY
                                </button>
                            </div>
                        </div>
                    </div>
                </div>

                <nav class="text-right">
                    {$pagination_html}
                </nav> 
            </div>
         </div>
    </div>
</section> 
<!-- </div> -->
<div class="modal fade hb-modal" id="bid-history">
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
                <h5 class="text-center">There is no bid.</h5>
                <!-- <table class="table table-hover">
                    <thead>
                        <tr>
                            <th>User Name</th>
                            <th>Date & Time</th>
                            <th>Amount</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>Mattxxxxxxxxxx</td>
                            <td>03/11/2019 00:47:05 AM</td>
                            <td>US $ 200.00</td>
                        </tr>
                        <tr>
                            <td>Mattxxxxxxxxxx</td>
                            <td>03/11/2019 00:47:05 AM</td>
                            <td>US $ 200.00</td>
                        </tr>
                        <tr>
                            <td>Mattxxxxxxxxxx</td>
                            <td>03/11/2019 00:47:05 AM</td>
                            <td>US $ 200.00</td>
                        </tr>
                        <tr>
                            <td>Mattxxxxxxxxxx</td>
                            <td>03/11/2019 00:47:05 AM</td>
                            <td>US $ 200.00</td>
                        </tr>
                        <tr>
                            <td>Mattxxxxxxxxxx</td>
                            <td>03/11/2019 00:47:05 AM</td>
                            <td>US $ 200.00</td>
                        </tr>
                        <tr>
                            <td>Mattxxxxxxxxxx</td>
                            <td>03/11/2019 00:47:05 AM</td>
                            <td>US $ 200.00</td>
                        </tr>
                    </tbody>
                </table> -->
            </div> 
        </div>
    </div>
</div>

<input type="hidden" name="page" value="{$currentPage}" id="page">

{include file="/common/footer-1.tpl" nocache}

{foreach $products as $key => $val}
{include file="time-loader.tpl" nocache}
{/foreach}

<script language="javascript" type="text/javascript">
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