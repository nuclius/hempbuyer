<div class="container">
    <!-- Rucurring purchase cancel -->
    <div class="modal reccuring-modal fade" id="rec-cancel" role="dialog">
        <div class="modal-dialog modal-sm" style="width: 35% !important;">
            <div class="modal-content">
                <div class="modal-header border-0">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <div class="panel panel-success">
                        <div class="panel-heading green-bg">
                            <h3>Are you sure ?</h3>
                        </div>
                    </div>
                </div>
                <div class="modal-body">
                    <p class="description">
                        Cancellation will incur a fee equal to 25% of the remaining contracted cost if you have cancellation insurance. If do not not have cancellation insurance, then it will incur a fee of 50% of the remaining contracted value.
                    </p>
                    <input type="hidden" id="rid" class="rid" name="rid" value="">
                </div>
                <div class="modal-footer">
                    <button class="btn btn-default btn-d black-g btnrecurg" type="button" name="button" data-toggle="modal" data-target="#">Confirm </button>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Seller Message -->
<div class="container">
    <!-- Modal -->
    <div class="modal fade" id="viewMessage" role="dialog">
        <div class="modal-dialog modal-sm wd50"  >
            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header p0">
                    <div class="panel panel-success border-0">
                        <div class="panel-heading green-bg">
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                            <h3>Message</h3>
                        </div>
                    </div>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="col-md-offset-1 col-md-10">
                            <p id="rej_msg" class="description mess123">
                            </p>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button class="btn btn-default btn-d-b green-b m0" type="button" data-dismiss="modal">CLOSE</button>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="container">
    <!-- Modal -->
    <div class="modal fade" id="viewMessage1" role="dialog">
        <div class="modal-dialog modal-sm wd50" style=" ">
            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header p0">
                    <div class="panel panel-success border-0">
                        <div class="panel-heading green-bg">
                            <h3>Message</h3>
                        </div>
                    </div>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="col-md-offset-1 col-md-10">
                            <p id="rej_msg1" class="description mess1231">
                            </p>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button class="btn btn-default btn-d-b green-b m0" type="button" data-dismiss="modal">CLOSE</button>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Reject message enter -->
<div class="container">
    <from data-parsley-validate>
    <!-- Modal -->
    <div class="modal fade" id="rejectMessage" role="dialog">
        <div class="modal-dialog modal-sm wd50">
            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header p0">
                    <div class="panel panel-success border-0">
                        <div class="panel-heading green-bg">
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                            <h3>Enter Your Message</h3>
                        </div>
                    </div>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="col-md-offset-1 col-md-10">
                            <p class="description1">
                                <input type="hidden" id="bid" class="bid" name="bid" value="">
                                <textarea class="grey-bg w100 border-0 p15 pb15 rmesg" placeholder="Please Comment Here" name="rmesg" rows="9" cols="80" required></textarea>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button class="btn btn-default btn-d-b green-b m0 rejmesgsend" type="button">SEND</button>
                </div>
            </div>
        </div>
    </div>
</from>
</div>

<div class="modal fade" id="feedbackinfo" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header p0">                   
              <div class="panel panel-success border-0">
                <div class="panel-heading green-bg">
                <h2 style="color: #000;font-size: 20px;font-weight: bold;">{$phrase.feedback}</h2>
                </div>
              </div>
            </div>
            <div class="modal-body info-data">
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="shippinginfo" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-sm wd50"  >
        <div class="modal-content">
                    <div class="modal-header p0">                   
              <div class="panel panel-success border-0">
                <div class="panel-heading green-bg">
                <h3>{$phrase.shipping_info}</h3>
                </div>
              </div>
            </div>
            <div class="modal-body info-data">
                <div class="row">
                    <div class="col-md-12">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label>Shipping User Info:</label>
                                buyer buyer buyerauctionf@gmail.com
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label>Tracking Info:</label>
                                test
                            </div>
                        </div>
                    </div>
                    <div class="col-md-12">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label>Phone:</label>
                                784758484748
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label>Tracking Service:</label>
                                fedex
                            </div>
                        </div>
                    </div>
                    <div class="col-md-12">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label>Shipping Address: </label>
                                Badghis, Schenectady County, Afghanistan, 12345
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label>Tracking Number:</label>
                                123455
                            </div>
                        </div>
                    </div>
                    <div class="col-md-12">
                        <input type="submit" class="btn btn-default btn-d-b green-b shadow-btn m0" value="Close" 
                        onclick="$('.modal').modal('hide');">
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="container-fluid bgBannerFluid">
    <h1>{$heading_common}</h1> {include file="common/common_navigation.tpl" nocache}
</div>