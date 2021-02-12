{include file="common/header-1.tpl" nocache}
    <div class="row">
      <div class="col-md-2 left_col">
        <div class="white_box">
          <div class="whead">{$pharse.welcome}</div>
          <div class="b_lbl">{$pharse.we_support_below_types_in_our_release_1}</div>

          <div class="wb_lbl"><i class="fa fa-caret-right"></i>{$pharse.what_is_penny_auction?}</div>
          <div class="wb_lbl"><i class="fa fa-caret-right"></i>{$pharse.what_is _peak_auction?}</div>
          <div class="wb_lbl"><i class="fa fa-caret-right"></i>{$pharse.reserve_bidding}</div>
        </div>
        <div class="white_box">
          <div class="whead">{$phares.bidding_type}</div>
           <div class="wb_lbl"><i class="fa fa-caret-right"></i>{$pharse.beginner}</div>
           <div class="wb_lbl"><i class="fa fa-caret-right"></i>{$pharse.penny_auction}</div>
           <div class="wb_lbl"><i class="fa fa-caret-right"></i>{$pharse.peak_auction}</div>
           <div class="wb_lbl"><i class="fa fa-caret-right"></i>{$pharse.reverse_auction}</div>
        </div>
        <div class="reg_try">
          <img src="{$config.url}/images/reg_try.png" alt="" />
        </div>
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
        <div class="winners">{$pharse.winners}</div>
        {foreach $projects as $key => $val} 
        <div class="panel panel-primary bb_box">
          <div class="panel-body">
            <div class="wp_left">
              <div class="media">
                <div class="pull-left media-object blue_bck">
                  <img src="{if $val.uavatar == ''} {$config['imgpath']}no_img.png {else if $val.uavatar != ''}{$config['imgpath']}profile/{$val.uavatar}{/if}" width="100" height="100" alt="{$val.title}" title="{$val.title}" border="0"></div>
               
                {assign var="percentage" value=($val.mprice*100/$val.wprice}
                <div class="media-body">
                  <div>{$val.title}</div>
                  <div>{$pharse.bought_for_only:}{$val.wprice}</div>
                  <div>{$pharse.price:}{$val.mprice}</div>
                  <div>{$pharse.auction_closed_on:}{$val.date_closed}</div>
                </div>
              </div>
              <div class="wpro_btm">
                <div class="con_lbl pblue_txt">{%pharse.winner:}{$val.name}</div>
                <div class="con_lbl pred_txt">{$pharse.location:}{$val.state}</div>
                <div class="con_lbl pred_txt">{$val.country}</div>
                <!--<div class="con_lbl pblue_txt">Profile:{$val.profile}</div>-->
              </div>
            </div>
            <div class="wp_right">
              <div class="green_ribbon">{$pharse.you_saved}  {$percentage}%</div>
              <div>
                <img src="{if $val.avatar == ''} {$config['imgpath']}no_img.png {else if $val.avatar != ''}{$config['imgpath']}product/{$val.avatar}{/if}" width="122" height="122" alt="{$val.title}" title="{$val.title}" border="0"></div>
                
            </div>
          </div>
        </div>
        {/foreach}
      </div>
    </div>
    <div class="node_jsb">
    <div class="pull-left njsb">
      <div class="pbld">Product build <span>via</span></div>
    </div>
    <div class="pull-left left_nj">
    <p>{$pharse.after_detailed_research_we_built_in_node.js._problem_is_in_bidding_for_penny_auction_in_php_other_softwares_when_2-3_bidders_bid_there_is_a_delay_in_response._in_node.js_server_responds_back_in_milliseconds_and_has_data_for}</p>

    <p>1). {$pharse.have_you_ever_worked_with_real_time_events?_if_so,_(node.js_penny_auction_by_auctionsoftware.com)_is_the_best_solution}</p>

    <p>2). {$pharse.what_would_you_plan_to_use_for_storing_real-time_bidding_while_processing_it_server_–>_client_and_reverse_(mysql_or_other_database/storage)?_we're_talking_about_millisecond_events_here_that_can_be_accomplished_only_via_node.js_software_for_penny_developed_by_auctionsoftware.com}</p>
    </div>
    </div>

{include file="common/footer-1.tpl" nocache} 
