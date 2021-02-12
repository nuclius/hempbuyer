{include file="common/header-1.tpl" nocache}

<style type="text/css">

.modal-open{
	position:unset;
}
</style>
<div class="col-md-12" >
  <div class="col-md-8 how_works" style="padding:30px 0;">
  	 {if $action_sent}
        <div class="row">
          <div class="bg bg-success padding-20  m-top-40"> <i class="fa fa-warning"></i> {$pharse.your_dispute_sent} </div>
        </div>
    {/if}
    <h3 class="hiw_heading" style="padding-bottom:2%;">{$pharse.dispute}</h3>
    <form method="post" data-validate="parsley" enctype="multipart/form-data" id="review-form" action="{$config.url}/dispute">
    <div class="control-group">
      <div class="col-md-12" style="padding-left:0;margin-bottom: 10px;">{$pharse.subject}</div>
      <div class="col-md-12" style="margin-bottom: 10px; padding-left:0;">
        <input name="subject"  data-parsley-group="block1" required id="subject" maxlength="99" value="" onkeyup="return limitlength(this,99,'info_label')" type="text" class="form-control">
      </div>
      </div>
      <div class="control-group">
      <div class="col-md-12" style="padding-left:0;margin-bottom: 10px;">{$pharse.message*}</div>
      <div class="col-md-12" style="margin-bottom: 10px;padding-left:0">
        <textarea class="form-control" rows="4"  name="message" id="message" required></textarea>
      </div>  
      </div>
      <div class="control-group">  
      <div class="col-md-12" style="padding-left:0">
          <button class="btn btn-primary">{$pharse.submit}</button>
      </div> 
      </div>
    </form>
  </div>
  <div class="col-md-3 pull-right how_works">
   <div class="panel panel-default">
      <div class="panel-heading"> {$pharse.write_a_review} </div>
      <div class="panel-body">
        <div> {$pharse.dear_user_or_visitor,} </div>
        <div> {$pharse.we_encourage_all_of_our_customers_to_share_their_thoughts,_so_if_you'd_like_to_be_featured_in_one_of_our_customer_review_posts_and_tell_us_what’s_on_your_mind!} </div>
        <button class="btn btn-primary" data-toggle="modal" data-target="#review_form">{$pharse.click_here_to_review}</button>
      </div>
    </div>
    <div class="panel panel-default" style="margin-top:50px;">
      <div class="panel-heading">{$pharse.contact_support}</div>
      <div class="panel-body" style="line-height:24px;"> {$pharse.got_a_question?_we’ve_got_answers._for_simple_solutions,_check_out_our_easy-to-access_help_section._for_stickier_situations,_please_email_us_at} <a href="" style="line-height:40px;">{$pharse.support@auctionsoftware.com} </a> </div>
    </div>
  </div>
</div>

<div class="ds modal fade fcorn-register reg" id="review_form" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-header csgray_box">
    <button type="button" class="close" data-dismiss="modal" aria-hidden="true" id="close_buttons_register">{$pharse.x}</button>
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