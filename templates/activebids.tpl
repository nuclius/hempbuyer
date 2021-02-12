<!--============================================================================*\
|| ########################################################################## ||
|| # Auction Software Marketplace[*]version[*] Build [*]build[*]
|| # ---------------------------------------------------------------------- # ||
|| # Customer License # [*]license[*]
|| # ---------------------------------------------------------------------- # ||
|| # Copyright ©2014–[*]year[*] Develop Scripts LLC. All Rights Reserved    # ||
|| # This file may not be redistributed in whole or significant part.       # ||
|| # ------------- AUCTION SOFTWARE IS NOT FREE SOFTWARE ------------------ # ||
|| # http://www.auctionsoftwaremarketplace.com|support@auctionsoftware.com  # ||
|| # ---------------------------------------------------------------------- # ||
|| ########################################################################## ||
\*============================================================================ -->
{include file="common/header-1.tpl" nocache} {include file="common/buyer-head.tpl" nocache} {include file="time-common-loader.tpl" nocache}
<h3>My Orders</h3>
<div class="darkgray-form">
    <div class="tabs-form">
        <ul class="tabz">
            <a href="{$config['url']}/dashboard/activebids">
                <li {if $cmd !='lost' }class="active" {/if}>Active Bids</li>
            </a>
            <a href="{$config['url']}/dashboard/wonbids">
                <li>Bids Won</li>
            </a>
            <a href="{$config['url']}/dashboard/myorders">
                <li>Buy Now</li>
            </a>
            <a href="{$config['url']}/dashboard/activebids?cmd=lost">
                <li {if $cmd=='lost' } class="active" {/if}>Bids Lost</li>
            </a>
        </ul>
        <div class="tabz-content">
            <form method="post" action="{if $cmd}{$config.url}/dashboard/activebids?cmd={$cmd}{else}{$config.url}/dashboard/activebids{/if}" name="frmSearchBuyerOrder" id="frmSearchBuyerOrder" class="siteForm ondark" rel="search">
                <table width="100%">
                    <tbody>
                        <tr>
                            <td>
                                <input class="search_filter" type="text" name="searchtitle" value="{$searchtitle}" placeholder="Keyword" title="">
                            </td>
                            <td>
                                <input type="text" name="searchdateFrom" value="{$datefrom}" placeholder="Date From" id="datefrom" class="search_filter date-pick calendar" title=""> </td>
                            <td>
                                <input type="text" name="searchdateTo" value="{$dateto}" id="dateto" placeholder="Date To" class="search_filter date-pick calendar" title="" readonly autocomplete="off"> </td>
                            <td>
                                <input type="text" name="pricefrom" value="{$pricefrom}" class="search_filter" placeholder="Order From [$]" title="">
                            </td>
                            <td>
                                <input type="text" name="priceto" value="{$priceto}" class="search_filter" placeholder="Order To [$]" title="">
                            </td>
                            <td>
                                <input type="submit" name="btn_submit" id="btn_submit" title="" value="Search">
                            </td>
                            <td> <a class="buttonNormal clearValues" href="javascript:void(0);">Clear</a></td>
                        </tr>
                    </tbody>
                </table>
            </form>
        </div>
    </div>
</div>
<div class="tbl-listing">
    <h4>Items {$start_count} to {$end_count} of {$cnt} total</h4>
    <table>
        <tbody>
            <tr>
                <th width="15%">Image</th>
                <th width="40%">Ordered Products</th>
                <th width="10%">Total</th>
                <th width="15%">Time to Close</th>
                <!-- <th width="25%">Action</th> -->
            </tr>
            {if $mybids|count
            <=0 } <tr> {$phrase.no_bids_found} </tr>
                {else} {foreach $mybids as $key => $val}
                <tr>
                    <td>
                        <div class="avatar"><img class="mail2 img-responsive img-circle" src="{if $val.avatar == ''} {$config['imgpath']}no_img.png {else if $val.avatar != ''}{$config['imgpath']}product/{$val.avatar}{/if}" title="No Photo" alt="no_img" />
                        </div>
                    </td>
                    <td class="cellitem"><span class="cellcaption">Ordered Products</span> {$val.title} (Qty:{if $val.qty == ''} 1 {else if $val.qty != ''} {$val.qty} {/if})
                    </td>
                    <td nowrap="nowrap"><span class="cellcaption">Total</span> {$currency} {$val.proposed_amount - $val.refund_amount}</td>
                    <td nowrap="nowrap"><span class="cellcaption">Status</span>
                        <div class="timer_box" {if $val.status=='draft' || $val.buynow==1 }style="display:none" {/if}>{if $val.status == 'open' or $val.status == 'draft'}<span id="my{$val.id}">{$val.day}</span> {else if $val.status != 'open'}Closed {/if}
                        </div>
                        {include file="time-loader.tpl" nocache}
                    </td>
                </tr>
                {/foreach} {/if}
        </tbody>
    </table>
    <div class="pager">
        <div class="col-md-6 text-right">{$pagination_html}</div>
    </div>
</div>
</div>
</div>
</div>
</div>
<script type="text/javascript">
function doAction(cmd, id) {
    if (cmd == 'release_buy') {
        var r = confirm("Are You sure yo want to release the fund?");
        if (r == true) {
            window.location = '{$config.url}/dashboard/payment/release/buy/' + id
        } else {
            return false;
        }
    }
    if (cmd == 'cancel_buy') {
        var r = confirm("Are You sure yo want to cancel the fund?");
        if (r == true) {
            window.location = '{$config.url}/dashboard/payment/cancel/buy/' + id
        } else {
            return false;
        }
    }
    if (cmd == 'release') {
        var r = confirm("Are You sure yo want to release the fund?");
        if (r == true) {
            window.location = '{$config.url}/dashboard/payment/release/bid/' + id
        } else {
            return false;
        }
    }
    if (cmd == 'cancel') {
        var r = confirm("Are You sure yo want to cancel the fund?");
        if (r == true) {
            window.location = '{$config.url}/dashboard/payment/release/bid/' + id
        } else {
            return false;
        }
    }
    if (cmd == 'feedback_buy') {

        window.location = '{$config.url}/dashboard/payment/feedback/buy/' + id
    }
    if (cmd == 'feedback') {

        window.location = '{$config.url}/dashboard/payment/feedback/bid/' + id

    }

}
$(function() {
    $('.clearValues').click(function() {
        $('input.search_filter').val('');
    });


    jQuery('#datefrom').datetimepicker({
        timepicker: false,
        format: 'Y/m/d',
        onShow: function(ct) {
            this.setOptions({
                maxDate: jQuery('#dateto').val() ? jQuery('#dateto').val() : false
            })
        },
    });

    jQuery('#dateto').datetimepicker({
        timepicker: false,
        format: 'Y/m/d',
        onShow: function(ct) {
            this.setOptions({
                minDate: jQuery('#datefrom').val() ? jQuery('#datefrom').val() : false
            })
        },
    });




});
</script>
{include file="/common/footer-1.tpl" nocache}
<div class="modal fade" id="feedbackinfo" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h2 style="color: #000;font-size: 20px;font-weight: bold;">{$phrase.feedback}</h2></div>
            <div class="modal-body info-data"></div>
        </div>
    </div>
</div>
<div class="modal fade" id="shippinginfo" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h2 style="color: #000;font-size: 20px;font-weight: bold;">{$phrase.shipping_info}</h2></div>
            <div class="modal-body info-data"></div>
        </div>
    </div>
</div>
