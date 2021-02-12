{include file="/common/header-1.tpl" nocache}<div class="row dashboard">
		<div class="col-md-3">
				  {include file="left-nav-dashboard.tpl" nocache}
				</div>
			<div class="col-md-8">
			<h4 class="ds_brd">{$pharse.dashboard}</h4>
		<div class="yu_curntly">{$pharse.you_currently_have_$_{$users.balance}_in_your_account}</div>
		<div class="yu_curntly">{$pharse.you_currently_used_$_{$users.reserve_amount}_from_your_account}</div>
		<div class="">
			<div class="dgray_box" onclick="window.location='{$config.url}/package/'">
				<div class="db_ibox"><img src="{$config.url}/images/db_icon1.png" alt="" /></div>
				<div class="db_bbox">{$pharse.buy_packages}</div>
			</div>	
			<div class="dgray_box" onclick="window.location='{$config.url}/dashboard/wonauctions'">
			<div class="db_ibox"><img src="{$config.url}/images/db_icon2.png" alt="" /></div>
				<div class="db_bbox">{$pharse.won_auction}</div>
			</div>
			<div class="dgray_box"  onclick="window.location='{$config.url}/dashboard/watchlist'">
			<div class="db_ibox"><img src="{$config.url}/images/db_icon3.png" alt="" /></div>
				<div class="db_bbox"> {$pharse.my_watchlist}</div>
			</div>
			<div class="dgray_box"  onclick="window.location='{$config.url}/dashboard/referral'">
			<div class="db_ibox"><img src="{$config.url}/images/db_icon4.png" alt="" /></div>
			<div class="db_bbox">{$pharse.earn_daily_bonus}</div>
			</div>
		</div>
		</div>
{include file="/common/footer-1.tpl" nocache}		