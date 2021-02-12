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
<script type="text/javascript">
function update(obj) {
  var date = new Date()

  var hours = date.getHours();
  if (hours < 10) hours = '0'+hours
  document.getElementById('hour').innerHTML = hours

  var minutes = date.getMinutes()
  if (minutes < 10) minutes = '0'+minutes
  document.getElementById('min').innerHTML = minutes

  var seconds = date.getSeconds()
  if (seconds < 10) seconds = '0'+seconds
  document.getElementById('sec').innerHTML = seconds
}
</script>
<div class="row">
<div class="col-md-2 left_col">
  <div class="white_box">
    <div class="whead">{$phrase.welcome}</div>
    <div class="b_lbl">{$phrase.we_support_below_types_in_our_release} 1</div>
    <div class="wb_lbl"><i class="fa fa-caret-right"></i>{$phrase.what_is_penny_auction}</div>
    <div class="wb_lbl"><i class="fa fa-caret-right"></i>{$phrase.what_is_peak_auction}</div>
    <div class="wb_lbl"><i class="fa fa-caret-right"></i>{$phrase.reserve_bidding}</div>
  </div>
  <div class="white_box">
    <div class="whead">{$phrase.bidding_type}</div>
    <div class="wb_lbl"><i class="fa fa-caret-right"></i>{$phrase.beginner}</div>
    <div class="wb_lbl"><i class="fa fa-caret-right"></i>{$phrase.penny_auction}</div>
    <div class="wb_lbl"><i class="fa fa-caret-right"></i>{$phrase.peak_auction}</div>
    <div class="wb_lbl"><i class="fa fa-caret-right"></i>{$phrase.reverse_auction}</div>
  </div>
  <div class="reg_try"> <img src="{$config.url}/images/reg_try.png" alt="" /> </div>
</div>
<div class="col-md-10">
<div class="banner">
  <div class="bann_rht">
    <div class="rb_head">{$phrase.own_your_penny_auction_at_auction_software_com}</div>
    <div class="rb_shead">{$phrase.our_penny_auction_product_runs_on_node_js}</div>
    <div class="clearfix">
      <div class="pull-left"><img src="{$config.url}/images/node_js.png" alt="" /></div>
      <div class="pull-right"><img src="{$config.url}/images/buy_now.png" alt="" /></div>
    </div>
  </div>
</div>
<div class="today_auctions">
  <div class="clearfix">
    <div class="pull-left td_act">{$pagetitle}</div>
  </div>
  {assign var="proj" value=$projects.project}
  {include file="projects-new.tpl" nocache} </div>
  </div>
  </div>
<div class="node_jsb">
  <div class="pull-left njsb">
    <div class="pbld">{$phrase.product_build} <span>{$phrase.via}</span></div>
  </div>
  <div class="pull-left left_nj">
    <p>{$phrase.after_detailed_research_we_built_in_node_js}.</p>
    <p>{$phrase.problem}</p>
    <p> 1. {$phrase.bidding_in_php_delay_in_response_from_server}
</p>
<p>{$phrase.solution}</p>
    <p>1. {$phrase.in_node_js_server_responds_back_in_milliseconds}</p>
    <p>2. {$phrase.have_you_ever_worked_with_real_time_events}</p>
    <p>3. {$phrase.what_would_you_plan_to_use_for_storing_real_time_bidding_while_processing_it_server}</p>
  </div>


</div>
<script> 

 function meee(id,dateee)
  {  

   clearInterval(clearvar[id]);
    clock[id] = document.getElementById('my'+id)
    , targetDate[id] = new Date(dateee); // Jan 1, 2050;
 
  clock[id].innerHTML = countdown(targetDate[id]).toString();
  clearvar[id] =  setInterval(function(){
    clock[id].innerHTML = countdown(targetDate[id]).toString();
  }, 1000);
    
  }
      socket.on('date', function(data){
        $('#txtdate').text(data.date);
    
    });
     socket.on('bidAddtime', function(msg){   
     meee(msg.id,msg.date);

     });

</script> 
{include file="common/footer-1.tpl" nocache}