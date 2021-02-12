{include file="common/header-1.tpl" nocache}
<div class="main_container">
  <div class="row dashboard">
    <div class="col-md-3"> {include file="left-nav-dashboard.tpl" nocache} </div>
    <div class="col-md-9">
      <h4 class="ds_brd">{$pharse.penny_won_auctions}</h4>
      <div class="row mblue_box">
        <div class="col-md-3">{$pharse.image}</div>
        <div class="col-md-2">{$pharse.title}</div>
        <div class="col-md-3">{$pharse.end_time} </div>
        <div class="col-md-2"> {$pharse.amount} </div>
        <div class="col-md-2"> {$pharse.status}</div>
      </div>
      {if $mybids|count <=  0}
        <div class="col-md-12 text-center m-top-20 font-12">{$pharse.no_results_found_found}</div>
              {else}
      {foreach $mybids as $key => $val}
      <div class="row mblue_box1">
        <div class="col-md-3"><a href=""><img src="{if $val.avatar == ''} {$config['imgpath']}no_img.png {else if $val.avatar != ''}{$config['imgpath']}product/{$val.avatar}{/if}" title="{$val.title}" width="65" height="65"></a></div>
        <div class="col-md-2"><a href="{$config['url']}/product/view/{$val.id}" title="{$val.ptitle}"> {$val.title}</a></div>
        <div class="col-md-3">{$val.date_closed}</div>
        <div class="col-md-2">{$val.proposed_amount}</div>
        <div class="col-md-2">{$val.status}</div>
      </div>
      {/foreach} 
      {/if} {$pagination_html} </div>
  </div>
</div>
</div>
{include file="common/footer-1.tpl" nocache} 