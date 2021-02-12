{include file="common/header-1.tpl" nocache}
<style type="text/css">
.pdbut .btn
{
  margin:10px;
}
</style>
<div class="container">
<div class="row fbck-container">
<div class="col-md-12">
  <div class="selft26">{$pharse.leave_feedback}</div>
</div>
</div>
<div class="row fbck-container">
  <form action="{$config.url}/dashboard/feedback/add" method="post" data-parsley-validate>
   <input type="hidden" value="{$projects.buynow_id}" name="bid" /> 
      <div class="col-md-2">
        <img src="{if $projects.avatar == ''} {$config['imgpath']}no_img.png {else if $projects.avatar != ''}{$config['imgpath']}product/{$projects.avatar}{/if}" class="img-responsive">
      </div>
      <div class="col-md-9">
        <div class="fb_item_title">{$projects.title} {$projects.id}</div>
        <div class="seller_ftlbl">{$pharse.seller:}{$projects.name}</div>
        <div class="seller_ftlbl1">{$pharse.leave_feedback_for_seller}</div>
        <div class="seller_ftlbl">{$pharse.please_enter_your_overall_response_for_this_experience.positive,neutral_or_negative}</div>
        <div class="ds fbck row">
          <div class="col-md-2">
            <label class="option srch_olbl"> 
              <input type="radio" type="radio"  value="Positive" name="stype" data-parsley-required>
              <span class="radio"></span>{$pharse.positive}
            </label>
          </div>
          <div class="col-md-2">
            <label class="option srch_olbl"> 
              <input type="radio" type="radio" value="Neutral" name="stype" data-parsley-required>
              <span class="radio"></span>{$pharse.neutral}
            </label>
          </div>
          <div class="col-md-2">
            <label class="option srch_olbl"> 
              <input type="radio" type="radio" value="Negative" name="stype" data-parsley-required>
              <span class="radio"></span>{$pharse.negative}
            </label>
          </div>
        </div>
        <div class="seller_ftlbl">{$pharse.please_explain}</div>
        <div>
          <textarea class="form-control" rows="4" name="content" data-parsley-required></textarea>
        </div>
        <div class="seller_ftlbl">
          {$pharse.please_select_the_closest_rating_specifics_using_the_chart_below}
        </div>
        <div class="row">
          <div class="col-xs-6 col-sm-6 col-md-3 seller_ftlbl">
            {$pharse.quality}
          </div>
          {$stype = 1}
          {include file="rate-star.tpl" nocache}
        </div>
        <div class="row">
          <div class="col-xs-6 col-sm-6 col-md-3 seller_ftlbl">
           {$pharse.delivery}
          </div>
          {$stype = 2}
          {include file="rate-star.tpl" nocache}
        </div>
        <div class="row">
          <div class="col-xs-6 col-sm-6 col-md-3 seller_ftlbl">
            {$pharse.price}
          </div>
          {$stype = 3}
          {include file="rate-star.tpl" nocache}
        </div>
        <div class="row">
          <div class="col-xs-6 col-sm-6 col-md-3 seller_ftlbl">
            {$pharse.communication}
          </div>
          {$stype = 4}
          {include file="rate-star.tpl" nocache}
        </div>
        <div class="row">
          <div class="col-xs-6 col-sm-6 col-md-3 seller_ftlbl">
            {$pharse.shipping_time}
          </div>
          {$stype = 5}
          {include file="rate-star.tpl" nocache}
        </div>
        <div class="row lbfdbck">
          <div class="col-xs-6 col-sm-6 col-md-4">
            <input type="submit" class="btn btn-danger" value="LEAVE FEEDBACK" style="color:#fff;"/>
              
          </div>
          <div class="col-md-2">
                      </div>
        </div>
      </div>
     </form> 
</div>
</div>

{include file="common/footer-1.tpl" nocache} 
<div class="modal fade" id="shippinginfo" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
     <div class="modal-header"></div>
     <div class="modal-body info-data"></div>    
    </div>
  </form>
  </div>

    </div>
  </div>
<script language="javascript" type="text/javascript">
          $(function() { $('.myp').addClass('act_class'); } );
     </script> 
<script type="text/javascript">
$(function()
{
  projectLoad();
});</script>

