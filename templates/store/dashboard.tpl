{include file="common/header-1.tpl" nocache}
{include file="store/css-store.tpl" nocache}
<!--Favicon
================================================== -->
<!--<script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/jquery-ui.min.js" type="text/javascript"></script> -->
<link rel="shortcut icon" href="https://auctionsoftwaremarketplace.com:2002/images/logo.ic.png">
<!--Google fonts
================================================== -->
<link href='https://fonts.googleapis.com/css?family=Open+Sans:300italic,400italic,600italic,700italic,800italic,400,600,700,800,300' rel='stylesheet' type='text/css' />
<!--bootstrap v3.0.2
================================================== -->
<link rel="stylesheet" type="text/css" href="../css/common_responsive1.css" />
<!--<link rel="stylesheet" href="https://auctionsoftwaremarketplace.com:2002/css/bootstrap.css"> -->
<!--font-awesome
================================================== -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css" type="text/css">
<!--CSS Custom
================================================== -->
<!--<link rel="stylesheet" type="text/css" href="https://auctionsoftwaremarketplace.com:2002/css/reset-min.css" />
<link rel="stylesheet" type="text/css" href="https://auctionsoftwaremarketplace.com:2002/css/common.css" />
<link rel="stylesheet" type="text/css" href="https://auctionsoftwaremarketplace.com:2002/css/style.css" />
<link rel="stylesheet" type="text/css" href="https://auctionsoftwaremarketplace.com:2002/css/theme0.css" /> -->
<link rel="stylesheet" type="text/css" href="https://auctionsoftwaremarketplace.com:2002/css/forward_home.css" />
<link rel="stylesheet" type="text/css" href="https://auctionsoftwaremarketplace.com:2002/css/owl.carousel.css" />
<link rel="stylesheet" type="text/css" href="https://auctionsoftwaremarketplace.com:2002/css/common_responsive1.css" />
<link rel="stylesheet" href="{$config.url}/css/jquery.datetimepicker.css" type="text/css" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.12.2/css/bootstrap-select.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.12.2/js/bootstrap-select.min.js"></script>

<style type="text/css">
	.dropdown-menu {
		margin-left: 37px;
	}
	.img-info {
        margin-top: 20px !important;
        position: unset;
    }
	/*.bck-img {
	    height: 195px;
	    max-width: 100%;
	}*/
	.bck-img {
	    height: auto;
	    width: 100%;
	}
    #addid_social  {
      width: 200px; height: 34px; position: relative; float: left; display: block; margin-right: 15px;
    }
    #socialnet{
         background:url('/images/home/social_add.png') no-repeat; width:185px; margin-top: -4px;height:34px; border:none; padding-left:35px;
    }
    .edit_body_mode .edit_mode {
        display: block;
    }
    .gry_but span
     {
        background: rgba(0, 0, 0, 0) url("/images/home/textbutton.png") no-repeat scroll 0 -96px;
        color: #5d5f62;
        display: block;
        font-family: Arial,Helvetica,sans-serif !important;
        font-size: 11px !important;
        font-weight: bold;
        margin-right: 7px;
        padding: 8px 3px 9px 10px;
        text-align: center;
    }
    #fac_id{
    float: left;
        margin-top: 0;
        display: none;
    }
    #twi_id{
     float: left;
        margin-top: 0;
        display: none;
    }
    #goo_id{
    float: left;
        margin-top: 0;
        display: none;
    }
    #web_id{
       display: none;
        float: left;
        margin-top: 0;
    }
    .removelink  {
        display: none;
    }
    .sociallink{
        display: none;
    }
    .upban{
         font-size: 12px;
        font-weight: normal;
        padding: 3px 20px;
        cursor: pointer;
    }
    /*.file-upload{
        background: white none repeat scroll 0 0;
        cursor: inherit;
        display: block;
        font-size: 100px;
        min-height: 100%;
        min-width: 100%;
        opacity: 0;
        outline: medium none;
        position: absolute;
        right: 0;
        text-align: right;
        top: 0;
    }*/
    #store_banner_image  {
      background: white none repeat scroll 0 0;
        cursor: inherit;
        display: block;
       /* font-size: 100px;
        min-height: 100%;*/
        min-width: 100%;
        opacity: 0;
        outline: medium none;
        position: absolute;
        right: 0;
        text-align: right;
        top: 0;
    }
    .bannerdrop {
        background-clip: padding-box;
        background-color: #fff;
        border: 1px solid rgba(0, 0, 0, 0.15);
        border-radius: 4px;
        box-shadow: 0 6px 12px rgba(0, 0, 0, 0.176);
        display: none;
        float: left;
        font-size: 14px;
        left: 0;
        list-style: outside none none;
        margin: 2px 0 0;
        min-width: 160px;
        padding: 5px 0;
        position: absolute;
        text-align: left;
        top: 100%;
        z-index: 1000;
    }
    .bannerdrop a {
        font-size: 12px;
    }
    .bannerdrop > li > a {
        clear: both;
        color: #333;
        display: block;
        font-weight: normal;
        line-height: 1.42857;
        padding: 3px 20px;
        white-space: nowrap;
    }
    .bannerli{
        display: none;
        cursor: pointer;
    }

    .gry_but span {
        background: rgba(0, 0, 0, 0) url("/images/home/textbutton.png") no-repeat scroll 0 -96px;
        color: #5d5f62;
        display: block;
        font-family: Arial,Helvetica,sans-serif !important;
        font-size: 11px !important;
        font-weight: bold;
        margin-right: 7px;
        padding: 8px 3px 9px 10px;
        text-align: center;
    }
    .save_reposition {
        bottom: 0px;
        display: none;
        position: absolute;
        right: 276px;
        width: 120px;
    }
    .gry_but {
        background: rgba(0, 0, 0, 0) url("/images/home/textbuttonend.png") no-repeat scroll right -96px;
        cursor: pointer;

        height: 31px;
        margin-left: 5px;
    }
    .ui-draggable-handle{
        cursor: move;
    }
         .stor_dat {
        border-bottom: 1px solid rgb(189, 184, 184);
        margin-top: 48px;
    }

    .stor_dat ul.product_view {
        display: inline-table;
        list-style: outside none none;
        margin: 0;
        padding: 0;
        position: relative;
        width: 1036px;
    }
    .stor_dat ul.product_view li.product_li {
        float: left;
        margin: 10px 8px;
        padding: 0;
        width: 130px;
    }
    .stor_dat ul li .container_img {
        box-shadow: 0 0 0 white;
        height: 140px;
        position: relative;
        width: 135px;
        z-index: 100;
    }
    .container_img div {
        /*overflow: hidden;*/
    }
    .stor_dat ul li .container_img .str-limg {
        cursor: pointer;
        margin-top: 1px;
        vertical-align: middle;
        width: 135px;
    }
    .str-limg .checker_off.off {
        background: rgba(0, 0, 0, 0) url("/images/home/off.png") no-repeat scroll 0 0;
    }
    .str-limg .checker_off.on {
        background: rgba(0, 0, 0, 0) url("/images/home/off.png") no-repeat scroll 0 -25px;
        bottom: 5.5px;
    }
    .str-limg .checker_off input {
        visibility: hidden;
    }
    .edit_body_mode .edit_mode {
        display: block;
    }
    .str-limg .checker_off {
        bottom: 5px;
        display: block;
        float: left;
        height: 18px;
        left: 5px;
        position: absolute;
        width: 18px;
        z-index: 100;
    }
    .scroll_container {
        background: #fff none repeat scroll 0 0;
    }

    .main_contents {
        clear: both;
        margin: 0 auto;
        overflow: hidden;
        width: 1024px;
    }
    .liconts-list {
        margin-top: 5px;
        width: 100%;
    }
    .strprd_hd {
        font-size: 25px;
        height: 35px;
        overflow: hidden;
    }
    .strprd_hd .p-head {
        float: left;
        font-size: 25px;
        overflow: hidden;
    }

    .strprd_hd .gry_but {
        float: left;
        margin: 4px;
    }
    .gry_but {
        background: rgba(0, 0, 0, 0) url("/images/home/textbuttonend.png") no-repeat scroll right -96px;
        cursor: pointer;
        display: block;
        height: 31px;
        margin-left: 5px;
    }

    .feature-buts {
        float: right;
        height: 43px;
        margin-right: -1px;
        overflow: hidden;
    }

    .edit_body_mode .edit_mode {
        display: block;
    }
    .strprd_hd .gry_but span {
        padding: 8px 1px 10px 10px;
    }
    .gry_but span {
        background: rgba(0, 0, 0, 0) url("/images/home/textbutton.png") no-repeat scroll 0 -96px;
        color: #5d5f62;
        display: block;
        font-family: Arial,Helvetica,sans-serif !important;
        font-size: 11px !important;
        font-weight: bold;
        margin-right: 7px;
        padding: 8px 3px 9px 10px;
        text-align: center;
    }
    .mm1e {
		border: 1px solid #bec0c2;
		border-radius: 3px;
		margin-top: 10px;
		width: 100%;
		display: table;
    }


    .sm-dt {
        float: left;
        margin-left: 10px;
        margin-right: 10px;
        width: 200px;
    }
    .grhg {
        background: #fff1d7 none repeat scroll 0 0;
        height: 40px;
        width: 100%;
    }
    .t-r-5 {
        overflow: hidden;
        width: 100%;
    }
    .h2-o {
        color: gray;
        float: left;
        margin-right: 25px;
        overflow: hidden;
    }
    .grhg span {
        margin-left: 10px;
        position: relative;
        top: 10px;
    }
    .ij-gr {
        height: 52px;
        padding-top: 14px;
        width: 100%;
    }
    .jqqw {
        float: left;
        font-size: 13px;
        margin-left: 20px;
        margin-top: 6px;
        overflow: hidden;
        width: 300px;
    }
    .witi {
        color: gray;
        margin-left: 40px;
        position: relative;
    }
    .bot-uu {
        background: rgba(0, 0, 0, 0) url("../../../images/dashboard/bot-sh.gif") repeat-x scroll 0 0;
        height: 7px;
        margin-top: 45px;
        position: relative;
        width: 100%;
    }
    .reports3 {
        width: 40%;
    }
    .reports4 {
        padding-top: 6px;
        width: 3.5%;
    }
    .reports41 {
        padding-top: 6px;
        width: 6%;
    }
    .reports41 span {
        font-weight: bold;
    }
    .block-wrapper {
        border-radius: 10px;
        font-size: 11px;
        margin-top: 10px;
    }

    .block .block-top {
        -moz-border-bottom-colors: none;
        -moz-border-left-colors: none;
        -moz-border-right-colors: none;
        -moz-border-top-colors: none;
        background-color: rgb(172, 170, 170);
        border-color: rgb(213, 213, 213) rgb(213, 213, 213) -moz-use-text-color;
        border-image: none;
        border-style: solid solid none;
        border-width: 1px 1px 0;
        position: relative;
    }

    .block .block-top .block-right {
        background: rgba(0, 0, 0, 0) url("../../../images/default/blocks/block_upper_right.gif") no-repeat scroll right top;
        position: relative;
        right: -1px;
        top: -1px;
    }

    .block .block-top .block-left {
        background: rgba(0, 0, 0, 0) url("../../../images/default/blocks/block_upper_left.gif") no-repeat scroll left top;
        font-size: 0;
        height: 6px;
        left: -2px;
        position: relative;
    }

    .block .block-header {
        background: black none repeat scroll 0 0;
        border-color: black;
        border-style: solid;
        border-width: 1px;
        color: white;
        font-size: 21px;
        font-weight: 400;
        padding: 8px 0 7px 20px;
        position: relative;
    }
    .grhg {
        background: #e4e4e4 none repeat scroll 0 0;
        height: 40px;
        width: 100%;
        border-bottom: 1px solid #bec0c2;
        width: 100%;
    }
    .grhd {
        list-style: outside none none;
        margin: 0;
        overflow: hidden;
        padding: 0;
    }
    .grhd li {
        float: left;
        height: 40px;
        text-align: center;
        width: 230px;
    }
    .grhg span {
        margin-left: 10px;
        position: relative;
        top: 10px;
    }
    .lkja .ij-gr {
        background: white none repeat scroll 0 0;
        border-bottom: 1px solid black;
        font-size: 12px;
        padding-top: 0;
    }
    .ij-gr {
        height: 52px;
        padding-top: 14px;
        width: 100%;
    }
    .jiti {
        height: 48px;
        width: 99.9%;
    }


    .td0h {
        float: left;
        height: 100%;
        text-align: center;
       width: 200px;
    }
    .td0h span {
        position: relative;
        top: 16px;
    }
    .block-wrapper .grhd li, .block-wrapper .jiti .td0h{
        width:33.333%;
    }

</style>
<!-- store section design -->
<div class="container-fluid store-head" style="margin-bottom:0px;">
    <div class="container">
        <div class="col-md-12">
			{if $singlestore == 'true'}
			<input type="hidden" id="storeid" class="form-control" value="{$store.id}">
            <div class="col-md-12 con"  style="height:200px;overflow:hidden;position:relative;">
				<div id="dvPreview3" style="height:500px;width:100%;position:absolute;">
					{if $store.banner != ''}
						<img src="{$config.url}/uploads/store/{$store.banner}" class="img-responsive banimg bck-img" style="top:{$store.btop}px;left:{$store.bleft}px;position: absolute;">
					{/if}
				</div>
                <input type="hidden" name="bleft" id="bleft">
                <input type="hidden" name="btop" id="btop">
                <input type="hidden" name="confurl" id="confurl" value="{$config.url}">
                <div class="col-md-12 img-info ah1">
					<div class="col-sm-2">
						{if $store.logo != ''}
							<img src="{$config.url}/uploads/store/{$store.logo}" style="max-height: 142px;height: 142px;max-width: 142px;width: 142px;" class="img-responsive">
						{else}
							<img src="{$config.url}/images/no_imf.png" style="max-width: 142px;width: 142px;max-height: 142px;height: 142px;" class="img-responsive">
						{/if}
					</div>
                    <div class="col-sm-10 text-right">
                        <div class="btn-group">
                            <button type="button" class="btn btn-default" onclick="window.location='{$config.url}/stores/view/{$store.id}'">View Store</button>
                            <button type="button" class="btn btn-default" onclick="window.location='{$config.url}/stores/dashboard/{$store.id}'">Dashboard</button>
                            <button type="button" class="btn btn-default" onclick="window.location='{$config.url}/stores/show_adwords/{$store.id}'">Advertising</button>
                        </div>
                    </div>
                </div>
            </div>
			{/if}
            <div class="col-md-12 bt-info">
				{if $singlestore == 'false'}
					<div class="h4 text-center">
						Stores Report
					</div>
					<input type="hidden" id="storeid" class="form-control" value="0">
				{/if}
                <div class="mm1e">
                    <div class="grhg">
                        <span>Customize report using search tools below</span>
                    </div>
					{if $singlestore == 'false'}
						<div class="form-group" style="margin-bottom: 66px;margin-top: 20px;">
							<label class="col-sm-2 control-label" style="margin-top: 8px;">Stores:</label>
							<div class="col-sm-5" style="margin-left: 45px;">
								<select name="rangepast" multiple id="allstores" class="form-control" multiple data-selected-text-format="count" data-live-search="true">
									{foreach $store as $key => $val}
									<option value="{$val.id}">{$val.name}</option>
									{/foreach}
								</select>
							</div>
						</div>
					{/if}
                    <div class="ij-gr form-group">
                        <label class="col-sm-2 control-label" style="margin-top: 8px;">From Range:</label>
                        <div class="col-sm-10">
                            <div class="col-sm-1 reports4" style="padding-left:0;">
                                <input type="radio" id="range" name="optionsRadios" value="range">
                            </div>
                            <div class="col-sm-2 reports3">
                                <input type="text" id="from_date" name="fromdate" class="form-control days date-picker" placeholder="2015-01-01" style="background-color: #fff !important;" >
                            </div>
                            <div class="col-sm-1 reports41">
                                <span>To:</span>
                            </div>
                            <div class="col-sm-2 reports3">
                                <input type="text" id="to_date" name="todate" class="form-control days date-picker" style="background-color: #fff !important;" placeholder="2015-01-01" >
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label"  style="margin-top: 10px;">Within:</label>
                        <div class="col-sm-7">
                            <div class="radio">
                                <label>
                                    <input type="radio" id="within" name="optionsRadios" value="fixed" checked>
                                    <select name="rangepast" id="rangepast" class="form-control" style="margin-left:23px;">
	                                    <option value="day">The Past Day</option>
	                                    <option value="week">The Past Week</option>
	                                    <option value="month">The Past Month</option>
	                                    <option value="year" selected>The Past Year</option>
                                    </select>
                                </label>
                            </div>
                        </div>
                        <div class="col-sm-2" style="margin-top:10px;margin-left:18px;">
                            <button name="submit" class="btn btn-success crt">Create Report</button>
                        </div>
                    </div>
                </div>
                <div class="">
                    <div class="block-wrapper" style="margin-top:10px;display: none;">
                        <div class="block">
                            <div class="block-header" >
                                <span>Product Sales</span>
                                <span style="float:right">
                                    <div class="sm-dt">
                                        <div class="gry_but" style="float: left;" onclick="print_sales();">
                                            <span>Print Sales</span>
                                        </div>
                                    </div>
                                </span>
                            </div>
                            <div id="show_box" class="block-content" style="padding:0px;">
                                <div class="grhg" style="border-left: 1px solid #bec0c2;border-right: 1px solid #bec0c2;width:100%;border-bottom: 1px solid;">
                                    <ul class="grhd">
                                        <li><span>Transaction Date/Time</span></li>
                                        <li><span>Name / Title</span></li>
                                        <li><span>Total Sale</span></li>
                                    </ul>
                                    <div class="bot-us_bk"></div>
                                </div>
                            </div>
                            <ul class="lkja">
                                <div></div>
                                <div style="overflow:hidden;margin-top:10px;float:"></div>
                            </ul>
                        </div>
                        <div class="block-footer">
                            <div class="block-right">
                                <div class="block-left"></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript">
	$(document).ready(function () {
		if($("#allstores").length > 0) {
			$('#allstores').selectpicker({
	            noneSelectedText: '0 stores selected'
	        });
			var allstoreid = [];
			$('#allstores option').each(function() {
				allstoreid.push($(this).attr('value'));
			});
			$('#allstores').selectpicker('val',allstoreid);
		}

		$(window).load(function() {
           if($('.banimg').length > 0) {
               var height  = $('.banimg').css('height');
                   height  = Number(height.replace('px',''))/195;
                   height  = Math.round(height) - 1;
               var ratio   = (height*2)+1;
               var fheight = ratio*195;
               var lheight = height*-195;
               $('#dvPreview3').css('height',fheight);
               $('#dvPreview3').css('top',lheight);
            //    $('.loader_div').hide();
           } else {
            //    $('.loader_div').hide();
           }
        });
        $('.main_wrapper').each(function() {
            $(this).prev().remove();
            $(this).attr('class','');
            $(this).children().attr('class','');
        });

        var currentDate = new Date();
        Date.dayNames   = ['Su', 'Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa'];
        Date.format     = 'yyyy-mm-dd';
        Date.format     = 'mm/dd/yyyy';
        $("#from_date").datetimepicker({
            formatDate  :'yyyy-mm-dd',
            pickTime    : false
        });
        $("#to_date").datetimepicker({
            formatDate  :'yyyy-mm-dd',
            pickTime    : false
        });


        $('body').on('click','.crt', function() {
            var method      = $("input[name=optionsRadios]:checked").val();
			if($("#allstores").length > 0) {
				var storeid  = $('#allstores').selectpicker('val');
				if (storeid != null) {
					storeid = storeid.toString();
				} else {
					alert('Please select atleast anyone store');
					return false;
					storeid = '0';
				}
			} else {
				var storeid = $('#storeid').val();
			}
            var within      = $("#rangepast").val();
            var from_date   = $("#from_date").val();
            var to_date     = $("#to_date").val();
            var myKey = {
                'method'    : method,
                'within'    : within,
                'from_date' : from_date,
                'to_date'   : to_date,
                'storeid'   : storeid
            };
            $.ajax({
                type    :"POST",
                url     :"/stores/reports_create",
                data    :myKey,
                dataType:"json",
                success:function(data) {
                   //console.log(data.res.length);
                    $(".lkja").html('');
                    var ress = data.res;
                    if(ress.length >0) {
                        for(j=0; j<ress.length; j++) {
                           //console.log(ress[j].date_added);
                           //console.log(data.res.date_added);
                            var ss = '<li>';
                                ss += '<div class="ij-gr">';
                                ss += '<div class="jiti">';
                                ss += '<div class="td0h"><span>'+ress[j].date_added+'</span></div>';
                                ss += '<div class="td0h"><span>'+ress[j].title+'</span></div>';
                                ss += '<div class="td0h"><span>'+ress[j].amount+'</span></div>';
                                ss += ' </div>';
                                ss += '<div class="bot-uu"></div>';
                                ss += '</div>';
                                ss += '</li>';
                            $(".lkja").append(ss);
                        }
                    } else {
                        var ss = '<li>';
                        ss += '<div class="ij-gr text-center" style="padding-top: 15px;">No Product Found</div>';
                        ss += '</li>';
                        $(".lkja").append(ss);
                    }
                }
            });
            $('.block-wrapper').fadeIn();
        });
        $('.crt').trigger('click');
    });
    function view_store(){
        var storeid = $('#storeid').val();
        window.location='{$config.url}/stores/view/'+storeid;
    }
    function print_sales() {
        var method =    $("input[name=optionsRadios]:checked").val();
		if($("#allstores").length > 0) {
			var storeid  = $('#allstores').selectpicker('val');
			if (storeid != null) {
				storeid = storeid.toString();
			} else {
				alert('Please select atleast anyone store');
				return false;
				storeid = '0';
			}
		} else {
			var storeid = $('#storeid').val();
		}
        var within =    $("#rangepast").val();
        var from_date = $("#from_date").val();
        var to_date = $("#to_date").val();
        var url = '{$config.url}/stores/reports_createcsv?method='+method+'&storeid='+storeid+'&within='+within+'&from_date='+from_date+'&to_date='+to_date;
        window.open(url,'_blank');
    }
</script>
<style media="screen">
.bootstrap-select .dropdown-toggle{
	margin-top: 0px !important;
	border-radius: 3px !important;
	padding: 6px !important;
	background: #fff !important;
}
</style>
{include file="common/footer-1.tpl" nocache}
{include file="store/store-js.tpl" nocache}
