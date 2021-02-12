
<div class="selft26">{$pharse.seller_dashboard}</div>

<div class="col-md-12 dashbrd12" id="dash-menu">
<div class="pull-left btn-group rmgn">
	<a class="btn btn-default" href="{$config.url}/dashboard/mybids">{$pharse.buyer}</a>
	<a class="btn btn-danger" href="javascript:void(0);">{$pharse.seller}</a>
</div>
<button type="button" class="navbar-toggle brht_menu pull-right collapsed" data-toggle="collapse" data-target="#bsb-collapse">
							<i class="fa fa-bars"></i> 
				</button>
    <div id="bsb-collapse" class="navbar-collapse white_nbb pull-right collapse" role="navigation">
	<div class="sidbrd2"><a href="{$config.url}/dashboard/my">{$pharse.i'm_selling}</a></div>
	<div class="sidbrd2"><a href="{$config.url}/dashboard/mysold">{$pharse.i've sold}</a></div>
	<div class="sidbrd2"><a href="{$config.url}/dashboard/my?cmd=draft">{$pharse.draft}</a></div>
	<div class="sidbrd2"><a href="{$config.url}/dashboard/my?cmd=closed">{$pharse.ended}</a></div>
</div>
</div>
<script type="text/javascript" charset="utf-8">
	//<![CDATA[
	var path = window.location.href;
	
	if(path.indexOf('?page') > -1 ){
		urls = path.split('?page')
		path = urls[0];
	}
	if(path.indexOf('&page') > -1 ){
		urls = path.split('&page')
		path = urls[0];
	}
	
	// Just grabbing a handy reference to it
	$('#dash-menu  a').each(function() {
		if (this.href === path) {
			$(this).addClass('active');
		}
	});
	//]]>
</script>