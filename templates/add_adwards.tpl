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

{include file="/common/header-1.tpl" nocache}
<link rel="stylesheet" type="text/css" href="{$config['externalcss']}/jquery.datetimepicker.css" />
<style>
    .padding_200 {
        padding: 7px 2px;
    }
</style>
<div class="row mjusd1" style="color:#242525;">{$phrase.adwords}</div>
{if $error} <div class="alert alert-danger">{$error}</div>{/if}
<div class="row">
    <div class="col-md-1"></div>
    <form action="/adwords/save" id="paypal-form" method="post" data-parsley-validate enctype="multipart/form-data">
        <input type="hidden" name="paymentMethodNonceInputField" id='paymentMethodNonceInputField' />
        <input type="hidden" name="id" id="id" value="{$adwords_details.id}"  />
        <input type="hidden" name="storeid" value="{$storeid}">
        <input type="hidden" name="pre_image" id="pre_image" value="{$adwords_details.banner}"  />
        <div class="col-md-10 mjusd4">
            <div class="row mjusd2">
                <div class="col-md-3">{$phrase.ad_name}*</div>
                <div class="col-md-7"><input type="text" class="form-control" name="ad_name" value="{$adwords_details.ad_name}" required/></div>
            </div>
            <div class="row mjusd2">
                <div class="col-md-3">{$phrase.ad_title}</div>
                <div class="col-md-7"><input type="text" class="form-control" name="ad_title" value="{$adwords_details.ad_title}" required /></div>
            </div>
           <div class="row mjusd2">
                <div class="col-md-3">{$phrase.ad_content} </div>
                <div class="col-md-7"><input type="text" class="form-control" value="{$adwords_details.ad_content}" name="ad_content" required/></div>
            </div>
            <div class="row mjusd2">
                <div class="col-md-3">{$phrase.ad_url}*</div>
                <div class="col-md-7"><input type="text" class="form-control" value="{$adwords_details.ad_url}"  name="ad_url" required/></div>
            </div>

            <div class="row mjusd2">
                <div class="col-md-3">{$phrase.banner}*</div>
                <div class="col-md-7">
                    <input type="file"  name="ad_image" {if $adwords_details.banner == ''} required {/if}/>
                </div>
            </div>
            <div class="row mjusd2">
                <div class="col-md-3">{$phrase.show_campaign} <br/>{$phrase.duration}</div>
                <div class="col-md-7">
                    <div class="radio">
                        <label>
                            <input type="radio" name="show_campaign" id="optionsRadios1" value="0"  checked >
                            Continuously (you can pause or remove your campaign any time)
                            {$phrase.continuously_you_can_pause}
                        </label>
                    </div>

                    <div class="radio">
                        <label>
                            <input type="radio" name="show_campaign" id="optionsRadios2" value="1" >
                            {$phrase.specific_date}
                        </label>
                    </div>

                    <input data-date-format="MM d, yyyy" name="end_date" id="date_addeddd" placeholder="mm/dd/yyyy"  autocomplete="off"  class="date-picker form-control hide" value="{$adwords_details.end_date}" data-parsley-group="block1" data-parsley-required-message="Please add start date" required maxlength="20"  type="text">

                </div>
            </div>
			<div class="row mjusd2">
                <div class="col-md-3">{$phrase.days_of_the_week}*</div>
                <div class="col-md-7">
                    <div class="checkbox">
                        <label>
                            <input type="checkbox" value="Sunday" name="days">
                            {$phrase.sunday}
                        </label>
                    </div>
                    <div class="checkbox">
                        <label>
                            <input type="checkbox" value="Monday" name="days">
                            {$phrase.monday}
                        </label>
                    </div>
                    <div class="checkbox">
                        <label>
                            <input type="checkbox" value="Tuesday" name="days">
                            {$phrase.tuesday}
                        </label>
                    </div>
                    <div class="checkbox">
                        <label>
                            <input type="checkbox" value="Wednesday" name="days">
                            {$phrase.wednesday}
                        </label>
                    </div>
                    <div class="checkbox">
                        <label>
                            <input type="checkbox" value="Thursday" name="days">
                            {$phrase.thursday}
                        </label>
                    </div>
                    <div class="checkbox">
                        <label>
                            <input type="checkbox" value="Friday" name="days">
                           {$phrase.friday}
                        </label>
                    </div>
                    <div class="checkbox">
                        <label>
                            <input type="checkbox" value="Saturday" name="days">
                            {$phrase.saturday}
                        </label>
                    </div>

                    <div class="col-md-12 mjusd3">
                        {$phrase.if_none_is_selected}
                    </div>

                </div>
            </div>
			<div class="row mjusd2">
                <div class="col-md-3">{$phrase.targeting_sections}*</div>
                <div class="col-md-7">

                    <!--<div class="checkbox">
                        <label>
                            <input type="checkbox" value="">
                            Buyer Signup
                        </label>
                    </div>-->
                    <div class="checkbox">
                        <label>
                            <input type="checkbox" value="Messages" name="target_section">
                            {$phrase.messages}
                        </label>
                    </div>
                    <div class="checkbox">
                        <label>
                            <input type="checkbox" value="Sell an Item" name="target_section">
                            {$phrase.sell_an_item}
                        </label>
                    </div>
                    <div class="checkbox">
                        <label>
                            <input type="checkbox" value="Seller DashBoard" name="target_section">
                            {$phrase.seller_dashboard}
                        </label>
                    </div>
                    <div class="checkbox">
                        <label>
                            <input type="checkbox" value="Buyer Dashboard" name="target_section">
                            {$phrase.buyer_dashboard}
                        </label>
                    </div>
                    <div class="checkbox">
                        <label>
                            <input type="checkbox" value="Product Page" name="target_section">
                            {$phrase.product_page}
                        </label>
                    </div>

                    <div class="checkbox">
                        <label>
                            <input type="checkbox" value="Membership" name="target_section">
                            {$phrase.membership_page}
                        </label>
                    </div>


                    <div class="col-md-12 mjusd3">
                        {$phrase.if_none_is_selected}
                    </div>

                </div>
            </div>

            <div class="row mjusd2">
                <div class="col-md-3">{$phrase.keywords}</div>
                <div class="col-md-7"><input type="text" class="form-control" name="keywords" value="{$adwords_details.keywords}"></div>
            </div>

            <div class="row mjusd2">
                <div class="col-md-3">{$phrase.campaign_budget}</div>
                <div class="col-md-7">
                    <div class="col-md-12 padlef0">
                        <div class="col-md-12 padlef0">{$phrase.your_bid_the_maximum}</div>
                        <div class="col-md-12 padlef0 padee5">
                            <div class="col-md-1 padlef0 mjusd5"><span class="curr_symbol">{$currency} </span></div>
                            <div class="col-md-4 padlef0"><input type="text" class="form-control" data-parsley-min="2" name="per_click_amount" value="{$adwords_details.budget_per_click}" required/></div>
                        </div>
                        <div class="col-md-12 padlef0 padee5">Minimum Bid: <span class="curr_symbol">{$currency} </span>2.00 {$phrase.per_click}</div>

                        <div class="col-md-12 padlef0 padee5">{$phrase.what_is_the_most_youre_willing_to_spend_per_day}</div>
                        <div class="col-md-12 padlef0 padee5">
                            <div class="col-md-1 padlef0 mjusd5"><span class="curr_symbol">{$currency} </span></div>
                            <div class="col-md-5 padlef0"><input type="text" class="form-control" name="per_day_amount" data-parsley-min="5"  value="{$adwords_details.budget_per_day}"required/></div>
                        </div>

                        <div class="col-md-12 padlef0 padee5">{$phrase.minimum_budget}<span class="curr_symbol">{$currency} </span>5.00 {$phrase.per_day}</div>

                    </div>
                </div>
            </div>
            <div class="col-md-12 text-center" style="margin-bottom: 13px;">
                <button type="submit" class="btn btn-danger">{if $adwords_details > 0} Update {else} Create {/if} Campaign</button>
            </div>



        </div>
    </form>

</div>
{include file="/common/footer-1.tpl" nocache}
<script type="text/javascript" src="{$config.url}/js/jquery.datetimepicker.js"></script>
<script>

    $(function() {

        $('input[name="days"]').each(function () {

            var k = ('({$adwords_details.days_week})').indexOf($(this).val());

            if (k > 0) {
                $(this).prop('checked', true);
            }
        });

        $('input[name="target_section"]').each(function () {
           //console.log($(this).val());

            var k = ('({$adwords_details.target_sec_id})').indexOf($(this).val());

            if (k > 0) {
                $(this).prop('checked', true);
            }
        });

        $('input[name="show_campaign"]').click('click',function()
        {
            if($(this).val() == 1){
                $('#date_addeddd').removeClass('hide');
            }else{
                $('#date_addeddd').addClass('hide');
            }

        });
        var aid = '{$adwords_details.id}';
        if(aid > 0)
            {
            if ('{$adwords_details.show_continue}' == 1){
            $('#optionsRadios2').prop('checked',true);
            $('#date_addeddd').removeClass('hide');

        }else{
            $('#optionsRadios1').prop('checked',true);
        }
        }

    });


</script>

<script language="javascript" type="text/javascript">
    $(function()
    {

        var serverdate = '{$serverdate}';
//alert(serverdate);
        d = servdate =  new Date(serverdate);

        jQuery('#date_addeddd').datetimepicker({
            // value: s,

            format:'m/d/Y',
            step:1,
            dateOnly : true,
            timepicker:false,
            futureOnly : true,
            // mask:'9999/19/39 29:59',
            // value: new Date(s),
            //defaultSelect:true,

            minDate:  new Date(serverdate),//new Date()
        });



    });
</script>
