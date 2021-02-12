<link  rel="stylesheet" type="text/css" href="{$config['externalcss']}my-boot.css" />
<link rel="stylesheet" type="text/css" href="{$config['externalcss']}reset-min.css" />
<link rel="stylesheet" type="text/css" href="{$config['externalcss']}reset-min.css" />
<link rel="stylesheet" type="text/css" href="{$config['externalcss']}forward_home.css" />
<link rel="stylesheet" type="text/css" href="{$config['externalcss']}jquery.datetimepicker.css" />
<script type="text/javascript" src="{$config.url}/js/jquery.datetimepicker.js"></script>
<link  rel="stylesheet" type="text/css" href="{$config['externalcss']}icon.css" />

<div class="wrapper">
<div class="profile-head clearfix no-print">
      
        <div class="threepin col-md-1"> <a href="#" class="menu-dashboard click_trigger" id="ct_2"> <span></span></a> </div>
        <div class="fl col-md-3">
          <div class="about-me">
           <!--  <div class="avatar"><img src="images/seldash.png" class="img-responsive img-circle" /></div>
            <div class="name">Maxixx <span>Los Angles, Chandigarh</span></div> -->
            {if $loged.userid > 0}
             
            <div class="name">{$loged.first_name} <span>{$loged.country}</span></div> 
            {/if}
          </div>
        </div>
       
      </div>
    </div>


    <div class="fixed-container">
      <div class="dashboard">
        <div class="left-data no-print" id="list_ct_2">
          <div class="dash-nav">
            <ul>
                <li class="dashboard">
                <a href="{$config['url']}/dashboard/buyer">
                <div class="dashb {$menu.buyer_dash}"></div>
                </a></li>

                <li class="colorchg {$menu.seller_dash}">
                <a href="{$config['url']}/profile_settings">
                <div class="accinfo "></div>
                </a></li>

                               
                 <li class="msg {$menu.messages}">
                <a href="{$config['url']}/dashboard/newmessages"> 
                <div class="msg {$menu.messages}"></div>
                </a></li>
                    
                <li class="credits {$menu.shareit}">
                <a href="{$config['url']}/dashboard/referrals"> 
                <div class="shareearn {$menu.shareit}"></div>
                </a></li>
                    
                <li class="cancellation-requests {$menu.orders}">
               <a href="{$config['url']}/dashboard/myorders">
               <div class="myord {$menu.orders}"></div>
               </a></li>
                         
               <li class="addressess {$menu.watclists}">
               <a href="{$config['url']}/dashboard/watchlist">
               <div class="favou {$menu.watclists}"></div>
               </a></li>

               <li class="addressess {$menu.credits}">
               <a href="{$config['url']}/dashboard/newpayments">
               <div class="mycredit {$menu.credits}"></div>
               </a></li>

          </ul>
          </div>
        </div>         <div class="data-side">
          <div class="tabz-dashboard">
            <ul class="tabz-ul">
               <li class=""><a href="{$config['url']}/dashboard/seller">Seller</a></li>
              <li class="active"><a href="{$config['url']}/dashboard/buyer">Buyer</a></li>
            </ul>
          </div>