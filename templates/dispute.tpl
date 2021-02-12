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

{include file="common/header-1.tpl" nocache}

<style type="text/css">

.modal-open{
	position:unset;
}
</style>
<div class="col-md-12" >
  <div class="col-md-8 how_works" style="padding:30px 0;">
  	 <h3 class="rev_head revcus">Reviews</h3>
               
                    {foreach $review as $key => $val} 
                     <div class="m-top-20">  
                    <div class="clearfix">
                        <div class="pull-left rhead">{$val.subject}</div>
                        <div class="pull-right rating">
                         {if $val.rating == .5} 
                            <img src="{$config.">url}/images/wstar.png" alt=""><img src="{$config.url}/images/wstar.png" alt=""><img src="{$config.url}/images/wstar.png" alt=""><img src="{$config.url}/images/wstar.png" alt=""><br /><span>"{$phrase.very_bad}"</span>
                           {elseif $val.rating == 1} 
                            <img src="{$config.url}/images/gstar.png" alt=""><img src="{$config.url}/images/wstar.png" alt=""><img src="{$config.url}/images/wstar.png" alt=""><img src="{$config.url}/images/wstar.png" alt=""><img src="{$config.url}/images/wstar.png" alt=""><br /><span>"{$phrase.bad}"</span>
                            {elseif $val.rating == 1.5} 
                            <img src="{$config.url}/images/gstar.png" alt=""><img src="{$config.url}/images/wstar.png" alt=""><img src="{$config.url}/images/wstar.png" alt=""><img src="{$config.url}/images/wstar.png" alt=""><img src="{$config.url}/images/wstar.png" alt=""><br /><span>"{$phrase.bad}"</span>
                           {elseif $val.rating == 2} 
                            <img src="{$config.url}/images/gstar.png" alt=""><img src="{$config.url}/images/gstar.png" alt=""><img src="{$config.url}/images/wstar.png" alt=""><img src="{$config.url}/images/wstar.png" alt=""><img src="{$config.url}/images/wstar.png" alt=""><br /><span>"{$phrase.bad}"</span>
                            {elseif $val.rating == '2.5'} 
                            <img src="{$config.url}/images/gstar.png" alt=""><img src="{$config.url}/images/gstar.png" alt=""><img src="{$config.url}/images/wstar.png" alt=""><img src="{$config.url}/images/wstar.png" alt=""><img src="{$config.url}/images/wstar.png" alt=""><br /><span>"{$phrase.normal}"</span>
                           {elseif $val.rating == 3} 
                            <img src="{$config.url}/images/gstar.png" alt=""><img src="{$config.url}/images/gstar.png" alt=""><img src="{$config.url}/images/gstar.png" alt=""><img src="{$config.url}/images/wstar.png" alt=""><img src="{$config.url}/images/wstar.png" alt=""><br /><span>"{$phrase.average}"</span>
                            {elseif $val.rating == '3.5'} 
                            <img src="{$config.url}/images/gstar.png" alt=""><img src="{$config.url}/images/gstar.png" alt=""><img src="{$config.url}/images/gstar.png" alt=""><img src="{$config.url}/images/wstar.png" alt=""><img src="{$config.url}/images/wstar.png" alt=""><br /><span>"$phrase.average}"</span>
                           {elseif $val.rating == 4} 
                            <img src="{$config.url}/images/gstar.png" alt=""><img src="{$config.url}/images/gstar.png" alt=""><img src="{$config.url}/images/gstar.png" alt=""><img src="{$config.url}/images/gstar.png" alt=""><img src="{$config.url}/images/wstar.png" alt=""><br /><span>"{$phrase.excellent}"</span>
                            {elseif $val.rating == '4.5'} 
                            <img src="{$config.url}/images/gstar.png" alt=""><img src="{$config.url}/images/gstar.png" alt=""><img src="{$config.url}/images/gstar.png" alt=""><img src="{$config.url}/images/gstar.png" alt=""><img src="{$config.url}/images/wstar.png" alt=""><br /><span>"$phrase.excellent}"</span>
                           {elseif $val.rating == 5} 
                            <img src="{$config.url}/images/gstar.png" alt=""><img src="{$config.url}/images/gstar.png" alt=""><img src="{$config.url}/images/gstar.png" alt=""><img src="{$config.url}/images/gstar.png" alt=""><img src="{$config.url}/images/gstar.png" alt=""><br /><span>"{$phrase.good}"</span>  
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
  <div class="col-md-3 pull-right how_works">
   <div class="panel panel-default">
      <div class="panel-heading"> {$phrase.write_a_review} </div>
      <div class="panel-body">
        <div> {$phrase.dear_user_or_visitor}, </div>
        <div> {$phrase.we_encourage_all_of_our_customers_to_share_their_thoughts} </div>
        <button class="btn btn-primary" data-toggle="modal" data-target="#review_form">{$phrase.click_here_to_review}</button>
      </div>
    </div>
    <div class="panel panel-default" style="margin-top:50px;">
      <div class="panel-heading">{$phrase.contact_support}</div>
      <div class="panel-body" style="line-height:24px;"> {$phrase.got_a_question} <a href="" style="line-height:40px;">support@auctionsoftware.com </a> </div>
    </div>
  </div>
</div>

<div class="ds modal fade fcorn-register reg" id="review_form" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-header csgray_box">
    <button type="button" class="close" data-dismiss="modal" aria-hidden="true" id="close_buttons_register">x</button>
    <h4 class="modal-title blue_txt">{$phrase.write_your_review}</h4>
  </div>
  <form method="post" data-validate="parsley" enctype="multipart/form-data" id="review-form" action="{$config.url}/dashboard/review/">
    <div class="form-wrapper">
      <div class="row">
        <div class="col-md-12">{$phrase.review_headline_if_you_could_say_it_in_one_sentence}</div>
  
        <div class="col-md-12">
          <input name="subject"  data-parsley-group="block1" required id="subject" maxlength="99" value="" onkeyup="return limitlength(this,99,'info_label')" type="text" class="col-md-12 form-control">  
        </div>
     
        <div class="col-md-12">{$phrase.write_your_review_minimum_120_characters}</div>
     
        <div class="col-md-12">
          <textarea name="message" id="message" class="col-md-12 form-control" required></textarea>
        </div>
   
    
        <div class="col-md-12">{$phrase.rate_our_service}</div>
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
{include file="common/footer-1.tpl" nocache} 
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