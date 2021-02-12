{include file="common/header-1.tpl" nocache}
<script src="{$config.url}/js/countdown.js"></script>
<!--{include file="time-common-loader.tpl" nocache}-->
<script type="text/javascript">
	var clock = [];
	var targetDate = [];
	var clearvar = [];
	var timeProject = [];
</script>

	<style>
	.height_65{

	}
</style>
<div class="row sellp1">
<div class="col-md-10 padlef0 pull-left">
{include file="seller-menu.tpl" nocache}
{if $projects|count <=  0}
   <div class="row mblue_box1 tno_bids"> {$pharse.no_products_found} </div> 
{else}      
{foreach $projects as $key => $val}
<div class="row sellp border-btm id{$val.id}" >
<div class="col-md-3 padlef0 photo_pbox">
<img src="{if $val.avatar == ''} {$config['imgpath']}no_img.png {else if $val.avatar != ''}{$config['imgpath']}product/{$val.avatar}{/if}" class="wd100">
</div>
<div class="col-md-9 msold_right">
<div class="Listft16"><a href="{$config['url']}/product/view/{$val.id}"  title="{$val.ptitle}"> {$val.title}</a><a href="{$config['url']}/dashboard/product/edit/{$val.id}" {if $val.bids!=0||$val.sold!=0} style="display:none;" {/if} title="{$val.ptitle}">{if $cmd != 'closed'}<span class="red21">{$pharse.edit}</span>{/if}</a></div>
<div class=" Lis14 text-justify height_65"><div style="color:black" style="overflow-x: hidden;">{$val.description}</div></div>
<div class="clearfix price">
 <div class="timer_box" {if $val.market_status == 'draft'}style="display:none"{/if}><span id="my{$val.id}">{if $val.status == 'open' or $val.status == 'draft'}{$val.day} {else if $val.status != 'open'}{$pharse.closed} {/if}</span></div>
 <div class="gray_bbox">{$pharse.quantity:}{$val.qty-$val.sold}</div>
 <div class="gray_bbox">{$pharse.sold:}{$val.sold}</div>
 {if $val.auction == 1}
 <div><button class="btn btn-default bid_hbtn" style="margin-top: 3px;"  onclick="bidHistory({$val.id})">{$pharse.bid_history}</button> &nbsp; <span style="color:red;font-weight:bold">{{$val.bids}} Bids</span></div>
 <div></div>
 {/if}
</div>
</div>
</div>
{include file="time-loader.tpl" nocache}
{/foreach}
{$pagination_html}
{/if}
</div>
<div class="dpad_zero col-md-2 col-xs-12 pull-right">
	<div class="r_btns"><a class="btn btn-danger" href="{$config.url}/product/post">{$pharse.sell_an_item}</a></div>
	<div class="r_btns"><a class="btn btn-default" href="{$config.url}/dashboard/messages">{$pharse.messages}</a></div>
	<div class="r_btns"><a class="btn btn-default" href="{$config.url}/profile_settings">{$pharse.profile}</a></div>
	<div class="r_btns"><a class="btn btn-default" href="{$config.url}/dashboard/payments">{$pharse.payments}</a></div>

	{include file="adwords.tpl" nocache}
</div>
</div>
{include file="common/footer-1.tpl" nocache} 
<div class="modal fade" id="bid_history" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
		  <div class="modal-header">
			<img src="{$config.url}/images/logoc.png" class="img-responsives"/>
			<button type="button" class="close" data-dismiss="modal" aria-label="Close"><img src="{$config.url}/images/close.png" style="position: absolute;right: -10px;top: -15px;" width="27px" height="27px" /></button>
		  </div>
		  <div class="modal-body bid_history">
			<h5 class="bid_hlbl">{$pharse.bid_history}</h5>
			<div class="panel panel-default">
				<div class="panel-heading">
					<div class="row">
						<div class="col-md-5">
							{$pharse.user_name/state}
						</div>
						<div class="col-md-4">
							{$pharse.date_&_time}
						</div>
						<div class="col-md-3">
						{$pharse.amount}
						</div>
					</div>
				</div>
				<div class="panel-body">
					<div class="row">
						<div class="col-md-5">
							{$pharse.1.user_name,_state}
						</div>
						<div class="col-md-4">
							Mar 15, 2015 ,11:14 PM
						</div>
						<div class="col-md-3">
						US $ 130.00
						</div>
					</div>
				</div>
			</div>
	  </div>
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
});
function bidHistory(id)
{
  $.ajax({
   url:'{$config.url}/bidhistory/'+id,
   type:'GET',
    success:function(data)
    {
       $('.panel-body').html(data.html);
       $('#bid_history').modal('show');
    }
  });
}

</script>


