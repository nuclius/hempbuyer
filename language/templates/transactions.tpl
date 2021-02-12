{include file="common/header-1.tpl" nocache}
<div class="main_container">
  <div class="row dashboard">
    <div class="col-md-3"> {include file="left-nav-dashboard.tpl" nocache} </div>
    <div class="col-md-9">
      <h4 class="ds_brd">{$pharse.my_transaction}</h4>
      <div class="row mblue_box">
        <div class="col-md-3">{$pharse.description} </div>
        <div class="col-md-1"> {$pharse.type}</div>
        <div class="col-md-2"> {$pharse.amount} </div>
        <div class="col-md-2">{$pharse.date}</div>
        <div class="col-md-2"> {$pharse.gateway} </div>
        <div class="col-md-1">{$pharse.status}</div>
      </div>
      {if $transaction|count <=  0}
      <div class="col-md-12 text-center m-top-20 font-12">{$pharse.no_results_found_found}</div>
      {else}
      {foreach $transaction as $key => $val}
      <div class="row mblue_box1">
        <div class="col-md-3">{$val.description} </div>
        <div class="col-md-1">{$val.type} </div>
        <div class="col-md-2">${$val.amount} </div>
        <div class="col-md-2">{$val.date_added}</div>
        <div class="col-md-2">{$val.gateway} </div>
        <div class="col-md-1">{$val.status} </div>
      </div>
      {/foreach}
      {/if}  {$pagination_html}</div>
  </div>
</div>
{include file="common/footer-1.tpl" nocache} 