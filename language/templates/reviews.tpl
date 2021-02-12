{include file="/common/header-1.tpl" nocache}


<style type="text/css">

.modal-open{
	position:unset;
}
.revcus {
	font-size:18px;
	font-weight:bold;
	padding-bottom:8px;
	border-bottom:1px solid #ccc;
	margin-bottom:8px;
}
</style>


<div class="row">

            <div class="col-md-8">
                <h3 class="rev_head revcus">{$pharse.reviews}</h3>

                    {foreach $review as $key => $val}
                     <div class="m-top-20">
                    <div class="clearfix">
                        <div class="pull-left rhead">{$val.subject}</div>
                        <div class="pull-right rating">
                         {if $val.rating == .5}
                            <img src="{$config.">url}/images/wstar.png" alt=""><img src="{$config.url}/images/gwstar.png" alt=""><img src="{$config.url}/images/wstar.png" alt=""><img src="{$config.url}/images/wstar.png" alt=""><br /><span>"{$pharse.very_poor}"</span>
                           {elseif $val.rating == 1}
                            <img src="{$config.url}/images/gstar.png" alt=""><img src="{$config.url}/images/wstar.png" alt=""><img src="{$config.url}/images/wstar.png" alt=""><img src="{$config.url}/images/wstar.png" alt=""><img src="{$config.url}/images/wstar.png" alt=""><br /><span>"Poor"</span>
                            {elseif $val.rating == 1.5}
                            <img src="{$config.url}/images/gstar.png" alt=""><img src="{$config.url}/images/gwstar.png" alt=""><img src="{$config.url}/images/wstar.png" alt=""><img src="{$config.url}/images/wstar.png" alt=""><img src="{$config.url}/images/wstar.png" alt=""><br /><span>"Fair"</span>
                           {elseif $val.rating == 2}
                            <img src="{$config.url}/images/gstar.png" alt=""><img src="{$config.url}/images/gstar.png" alt=""><img src="{$config.url}/images/wstar.png" alt=""><img src="{$config.url}/images/wstar.png" alt=""><img src="{$config.url}/images/wstar.png" alt=""><br /><span>"Fair"</span>
                            {elseif $val.rating == '2.5'}
                            <img src="{$config.url}/images/gstar.png" alt=""><img src="{$config.url}/images/gstar.png" alt=""><img src="{$config.url}/images/gwstar.png" alt=""><img src="{$config.url}/images/wstar.png" alt=""><img src="{$config.url}/images/wstar.png" alt=""><br /><span>"Average"</span>
                           {elseif $val.rating == 3}
                            <img src="{$config.url}/images/gstar.png" alt=""><img src="{$config.url}/images/gstar.png" alt=""><img src="{$config.url}/images/gstar.png" alt=""><img src="{$config.url}/images/wstar.png" alt=""><img src="{$config.url}/images/wstar.png" alt=""><br /><span>"Average"</span>
                            {elseif $val.rating == '3.5'}
                            <img src="{$config.url}/images/gstar.png" alt=""><img src="{$config.url}/images/gstar.png" alt=""><img src="{$config.url}/images/gstar.png" alt=""><img src="{$config.url}/images/gwstar.png" alt=""><img src="{$config.url}/images/wstar.png" alt=""><br /><span>"Good"</span>
                           {elseif $val.rating == 4}
                            <img src="{$config.url}/images/gstar.png" alt=""><img src="{$config.url}/images/gstar.png" alt=""><img src="{$config.url}/images/gstar.png" alt=""><img src="{$config.url}/images/gstar.png" alt=""><img src="{$config.url}/images/wstar.png" alt=""><br /><span>"Good"</span>
                            {elseif $val.rating == '4.5'}
                            <img src="{$config.url}/images/gstar.png" alt=""><img src="{$config.url}/images/gstar.png" alt=""><img src="{$config.url}/images/gstar.png" alt=""><img src="{$config.url}/images/gstar.png" alt=""><img src="{$config.url}/images/gwstar.png" alt=""><br /><span>"Very good"</span>
                           {elseif $val.rating == 5}
                            <img src="{$config.url}/images/gstar.png" alt=""><img src="{$config.url}/images/gstar.png" alt=""><img src="{$config.url}/images/gstar.png" alt=""><img src="{$config.url}/images/gstar.png" alt=""><img src="{$config.url}/images/gstar.png" alt=""><br /><span>"{$pharse.excellent}"</span>
                           {/if}
                        </div>
                    </div>
                    <p class="rev_txt">
                        {$val.message}.
                    </p>
                    <div class="customer_name">
                        - {$val.first_name} {$val.last_name}
                    </div></div>
                    {/foreach}
                    {$pagination_html}
            </div>

            <div class="col-md-4">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        {$pharse.write_a_review}
                    </div>
                    <div class="panel-body">
                        <div>
                            {$pharse.dear_user_or_visitor,}
                        </div>
                        <div>
                            {$pharse.we_encourage_all_of_our_customers_to_share_their_thoughts,_so_if_you'd_like_to_be_featured_in_one_of_our_customer_review_posts_and_tell_us_what's_on_your_mind!}
                        </div>
                        {if $loged.userid > 0}
                            <button class="btn btn-primary" data-toggle="modal" data-target="#review_form">{$pharse.click_here_to_review}</button>
                        {else}
                        <button class="btn btn-primary" onclick='location.href="/login"'>{$pharse.click_here_to_review}</button>
                        {/if}
                    </div>
                </div>
                    <div class="panel panel-default">
                    <div class="panel-heading">{$pharse.contact_support}</div>
                    <div class="panel-body">
                        {$pharse.got_a_question?_we've_got_answers._for_simple_solutions,_check_out_our_easy-to-access_help_section._for_stickier_situations,_please_email_us_at}
                        <a href="">support@auctionsoftware.com </a>
                    </div>
                    </div>
                </div>

            </div>
    <div class="ds modal fade fcorn-register reg" id="review_form" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-header csgray_box">
    <button type="button" class="close" data-dismiss="modal" aria-hidden="true" id="close_buttons_register">x</button>
    <h4 class="modal-title blue_txt">{$pharse.write_your_review}</h4>
  </div>
  <form method="post" data-validate="parsley" enctype="multipart/form-data" id="review-form" action="{$config.url}/dashboard/review/">
    <div class="form-wrapper">
      <div class="row">
        <div class="col-md-12">{$pharse.review_headline_(if_you_could_say_it_in_one_sentence,_what_would_you_say?)}</div>

        <div class="col-md-12">
          <input name="subject"  data-parsley-group="block1" required id="subject" maxlength="99" value="" onkeyup="return limitlength(this,99,'info_label')" type="text" class="col-md-12 form-control">
        </div>

        <div class="col-md-12">{$pharse.write_your_review_(minimum_120_characters)}</div>

        <div class="col-md-12">
          <textarea name="message" id="message" class="col-md-12 form-control" required></textarea>
        </div>


        <div class="col-md-12">{$pharse.rate_our_service}</div>
        <div class="ratings col-md-12">
          <input id="input-27" class="rating col-md-12 form-control"  name="rating">
        </div>

        <div class="col-md-12">
          <input type="submit" class="btn btn-primary" value="Submit">
        </div>

    </div>
    </div>
  </form>
  <div style="clear:both"></div>
</div>
{include file="/common/footer-1.tpl" nocache}

<script type="text/javascript">
$(function(){
    $('.main_container').addClass('review');
})

</script>
<script type="text/javascript">
$(function()
{
  $("#input-27").on("rating.change", function(event, value, caption) {
            $("#input-27").rating("refresh", {disabled:true, showClear:false});
            $("#input-27").val(value);
        });
});</script>