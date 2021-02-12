{include file="/common/header-1.tpl" nocache}
<link rel="stylesheet" type="text/css" href="{$config['externalcss']}/jquery.datetimepicker.css" />
<style>
    .padding_200 {
        padding: 7px 2px;
    }
</style>
<div class="col-md-12 mjusd1" style="color:#242525;">{$pharse.adwords}</div>
{if $error} <div class="alert alert-danger">{$error}</div>{/if}
<div class="col-md-12">
    <div class="col-md-1"></div>
    <form action="/adwords/save" id="paypal-form" method="post" data-parsley-validate enctype="multipart/form-data">
        <input type="hidden" name="paymentMethodNonceInputField" id='paymentMethodNonceInputField' />
        <input type="hidden" name="id" id="id" value="{$adwords_details.id}"  />

        <input type="hidden" name="pre_image" id="pre_image" value="{$adwords_details.banner}"  />
        <div class="col-md-10 mjusd4">
            <div class="col-md-12 mjusd2">
                <div class="col-md-3">{$pharse.ad_name*}</div>
                <div class="col-md-7"><input type="text" class="form-control" name="ad_name" value="{$adwords_details.ad_name}" required/></div>
            </div>
            <div class="col-md-12  mjusd2">
                <div class="col-md-3">{$pharse.ad_title}</div>
                <div class="col-md-7"><input type="text" class="form-control" name="ad_title" value="{$adwords_details.ad_title}" required /></div>
            </div>
            <div class="col-md-12 mjusd2">
                <div class="col-md-3">{$pharse.ad_content}</div>
                <div class="col-md-7"><input type="text" class="form-control" value="{$adwords_details.ad_content}" name="ad_content" required/></div>
            </div>
            <div class="col-md-12 mjusd2">
                <div class="col-md-3">{$pharse.ad_url*}</div>
                <div class="col-md-7"><input type="url" class="form-control" value="{$adwords_details.ad_url}"  name="ad_url" required/></div>
            </div>

            <div class="col-md-12 mjusd2">
                <div class="col-md-3">{$pharse.banner*}</div>
                <div class="col-md-7">
                    <input type="file"  name="ad_image" {if $adwords_details.banner == ''} required {/if}/>
                </div>
            </div>

            <div class="col-md-12 mjusd2">
                <div class="col-md-3">{$pharse.show_campaign} <br/>{$pharse.duration}</div>
                <div class="col-md-7">
                    <div class="radio">
                        <label>
                            <input type="radio" name="show_campaign" id="optionsRadios1" value="0"  checked >
                            {$pharse.continuously_(you_can_pause_or_remove_your_campaign_any_time)}
                        </label>
                    </div>

                    <div class="radio">
                        <label>
                            <input type="radio" name="show_campaign" id="optionsRadios2" value="1" >
                            {$pharse.specific_date}
                        </label>
                    </div>

                    <input data-date-format="MM d, yyyy" name="end_date" id="date_addeddd" placeholder="mm/dd/yyyy"  autocomplete="off"  class="date-picker form-control hide" value="{$adwords_details.end_date}" data-parsley-group="block1" data-parsley-required-message="Please add start date" required maxlength="20"  type="text">

                </div>
            </div>


            <div class="col-md-12 mjusd2">
                <div class="col-md-3">{$pharse.days_of_the_week*}</div>
                <div class="col-md-7">
                    <div class="checkbox">
                        <label>
                            <input type="checkbox" value="Sunday" name="days">
                            {$pharse.sunday}
                        </label>
                    </div>
                    <div class="checkbox">
                        <label>
                            <input type="checkbox" value="Monday" name="days">
                            {$pharse.monday}
                        </label>
                    </div>
                    <div class="checkbox">
                        <label>
                            <input type="checkbox" value="Tuesday" name="days">
                           {$pharse.tuesday}
                        </label>
                    </div>
                    <div class="checkbox">
                        <label>
                            <input type="checkbox" value="Wednesday" name="days">
                            {$pharse.wednesday}
                        </label>
                    </div>
                    <div class="checkbox">
                        <label>
                            <input type="checkbox" value="Thursday" name="days">
                            {$pharse.thursday}
                        </label>
                    </div>
                    <div class="checkbox">
                        <label>
                            <input type="checkbox" value="Friday" name="days">
                            {$pharse.friday}
                        </label>
                    </div>
                    <div class="checkbox">
                        <label>
                            <input type="checkbox" value="Saturday" name="days">
                            {$pharse.saturday}
                        </label>
                    </div>

                    <div class="col-md-12 mjusd3">
                        {$pharse.note:if_none_is_selected,_ad_will_get_displayed_in_all_sections}
                    </div>

                </div>
            </div>


            <div class="col-md-12 mjusd2">
                <div class="col-md-3">{$pharse.targeting_sections*}</div>
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
                            {$pharse.messages}
                        </label>
                    </div>
                    <div class="checkbox">
                        <label>
                            <input type="checkbox" value="Sell an Item" name="target_section">
                            {$pharse.sell_an_item}
                        </label>
                    </div>
                    <div class="checkbox">
                        <label>
                            <input type="checkbox" value="Seller DashBoard" name="target_section">
                            {$pharse.seller_dashBoard}
                        </label>
                    </div>
                    <div class="checkbox">
                        <label>
                            <input type="checkbox" value="Buyer Dashboard" name="target_section">
                            {$pharse.buyer_dashboard}
                        </label>
                    </div>
                    <div class="checkbox">
                        <label>
                            <input type="checkbox" value="Product Page" name="target_section">
                            {$pharse.product_page}
                        </label>
                    </div>

                    <div class="checkbox">
                        <label>
                            <input type="checkbox" value="Membership" name="target_section">
                            {$pharse.membership_page}
                        </label>
                    </div>


                    <div class="col-md-12 mjusd3">
                        {$pharse.note:if_none_is_selected,_ad_will_get_displayed_in_all_sections}
                    </div>

                </div>
            </div>

            <div class="col-md-12 mjusd2">
                <div class="col-md-3">{$pharse.keywords}</div>
                <div class="col-md-7"><input type="text" class="form-control" name="keywords" value="{$adwords_details.keywords}"></div>
            </div>

            <div class="col-md-12 mjusd2">
                <div class="col-md-3">{$pharse.campaign_budget}</div>
                <div class="col-md-7">
                    <div class="col-md-12 padlef0">
                        <div class="col-md-12 padlef0">{$pharse.your_bid_(the_maximum_you_are_willing_to_pay_per_click)}</div>
                        <div class="col-md-12 padlef0 padee5">
                            <div class="col-md-1 padlef0 mjusd5">$</div>
                            <div class="col-md-4 padlef0"><input type="text" class="form-control" data-parsley-min="2" name="per_click_amount" value="{$adwords_details.budget_per_click}" required/></div>
                        </div>
                        <div class="col-md-12 padlef0 padee5">{$pharse.minimum_bid_:_us$2.00_per_click}</div>

                        <div class="col-md-12 padlef0 padee5"> {$pharse.what_is_the_most_you're_willing_to_spend_per_day} </div>
                        <div class="col-md-12 padlef0 padee5">
                            <div class="col-md-1 padlef0 mjusd5">$</div>
                            <div class="col-md-5 padlef0"><input type="text" class="form-control" name="per_day_amount" data-parsley-min="5"  value="{$adwords_details.budget_per_day}"required/></div>
                        </div>

                        <div class="col-md-12 padlef0 padee5">{$pharse.minimum_budget_:_us$5.00_per_day} </div>

                    </div>
                </div>
            </div>


            <div class="col-md-12 text-center" style="margin-bottom: 13px;">
                <button type="submit" class="btn btn-danger">{if $adwords_details > 0} {$pharse.update} {else} Create {/if} {$pharse.campaign}</button>
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
            console.log($(this).val());

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





