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
    <div class="whead">{$pharse.welcome}</div>
    <div class="b_lbl">{$pharse.we_support_below_types_in_our_release_1}</div>
    <div class="wb_lbl"><i class="fa fa-caret-right"></i>{$pharse.what_is_penny_auction?}</div>
    <div class="wb_lbl"><i class="fa fa-caret-right"></i>{$pharse.what_is_peak_auction?}</div>
    <div class="wb_lbl"><i class="fa fa-caret-right"></i>{$pharse.reserve_bidding}</div>
  </div>
  <div class="white_box">
    <div class="whead">{$pharse.bidding_type}</div>
    <div class="wb_lbl"><i class="fa fa-caret-right"></i>{$pharse.beginner}</div>
    <div class="wb_lbl"><i class="fa fa-caret-right"></i>{$pharse.penny_auction}</div>
    <div class="wb_lbl"><i class="fa fa-caret-right"></i>{$pharse.peak_auction}</div>
    <div class="wb_lbl"><i class="fa fa-caret-right"></i>{$pharse.reverse_auction}</div>
  </div>
  <div class="reg_try"> <img src="{$config.url}/images/reg_try.png" alt="" /> </div>
</div>
<div class="col-md-10">
<div class="banner">
  <div class="bann_rht">
    <div class="rb_head">{$pharse.own_your_penny_auction_at_auction_software.com}</div>
    <div class="rb_shead">{$pharse.our_penny_auction_product_runs_on_node.js}</div>
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
    <div class="pbld">{$pharse.product_build} <span>{$pharse.via}</span></div>
  </div>
  <div class="pull-left left_nj">
    <p>{$pharse.after_detailed_research_we_built_in_node.js}</p>
    <p>{$pharse.problem}</p>
    <p> 1. {$pharse.bidding_in_php_delay_in_response_from_server._as_you_grow_to_million_of_users_server_slown_down_in_php}
</p>
<p>Solution</p>
    <p>1. {$pharse.in_node.js_server_responds_back_in_milliseconds}</p>
    <p>2. {$pharse.have_you_ever_worked_with_real_time_events?_if_so,_(node.js_penny_auction_by_auctionsoftware.com)_is_the_best_solution}</p>
    <p>3. {$pharse.what_would_you_plan_to_use_for_storing_real-time_bidding_while_processing_it_server_–>_client_and_reverse_(mysql_or_other_database/storage)?_we're_talking_about_millisecond_events_here_that_can_be_accomplished_only_via_node.js_developed_by_auctionsoftware.com}</p>
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