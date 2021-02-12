{include file="common/header-1.tpl" nocache}
<style media="screen">
    .loader_div .loader {
        height: 63px;
        margin-top: 20%;
        margin-left: 47%;
    }
    .loader_div {
        background: rgb(0, 0, 0);
        background: transparent;
        background: rgba(0, 0, 0, 0.5);/* FF3+,Saf3+,Opera 10.10+,Chrome,IE9*/
        filter:progid:DXImageTransform.Microsoft.gradient(startColorstr=#7f000000,endColorstr=#7f000000);/*IE 5.5-7*/
        -ms-filter: "progid:DXImageTransform.Microsoft.gradient(startColorstr=#7f000000,endColorstr=#7f000000)";/*IE8*/
        zoom: 1;
        width: 100%;
        height: 100%;
        z-index: 104;
        position: fixed;
        display: block;
        top: 0;
        left:0;
    }
</style>
<div class="loader_div">
    <img src="{$config.url}/images/ajaxloader.gif" alt="" class='loader'>
</div>
{include file="store/css-store.tpl" nocache}

    <!-- Favicon
  ================================================== -->
  <script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/jquery-ui.min.js" type="text/javascript"></script>
    <link rel="shortcut icon" href="https://auctionsoftwaremarketplace.com:2002/images/logo.ic.png">
    <!-- Google fonts
  ================================================== -->
    <link href='https://fonts.googleapis.com/css?family=Open+Sans:300italic,400italic,600italic,700italic,800italic,400,600,700,800,300' rel='stylesheet' type='text/css' />
    <!-- bootstrap v3.0.2
  ================================================== -->
  <link rel="stylesheet" type="text/css" href="../css/common_responsive1.css" />
    <!-- <link rel="stylesheet" href="https://auctionsoftwaremarketplace.com:2002/css/bootstrap.css"> -->
    <!--font-awesome
  ================================================== -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css" type="text/css">
    <!-- CSS Custom
  ================================================== -->
<!--     <link rel="stylesheet" type="text/css" href="https://auctionsoftwaremarketplace.com:2002/css/reset-min.css" />
    <link rel="stylesheet" type="text/css" href="https://auctionsoftwaremarketplace.com:2002/css/common.css" />
    <link rel="stylesheet" type="text/css" href="https://auctionsoftwaremarketplace.com:2002/css/style.css" />

    <link rel="stylesheet" type="text/css" href="https://auctionsoftwaremarketplace.com:2002/css/theme0.css" /> -->
    <link rel="stylesheet" type="text/css" href="https://auctionsoftwaremarketplace.com:2002/css/forward_home.css" />
    <link rel="stylesheet" type="text/css" href="https://auctionsoftwaremarketplace.com:2002/css/owl.carousel.css" />
    <link rel="stylesheet" type="text/css" href="https://auctionsoftwaremarketplace.com:2002/css/common_responsive1.css" />

<link rel="stylesheet" href="{$config.url}/css/jquery.datetimepicker.css" type="text/css" />
<style type="text/css">

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
    /*border-bottom: 1px solid rgb(189, 184, 184);*/
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
.dropdown-menu a span{
    cursor: pointer;
}
.add_social {
    width: 18px;
    height: 18px;
    position: absolute;
    top: 5px;
    left: 27px;
    cursor: pointer;
}
.pro_item{
    background-color: #fff;
}
.owldemosort {
    margin-bottom: 20px;
}
.owldemosort2 {
    border: 1px solid rgb(221, 221, 221);
}

.store-head .bt-info .btn-group .btn:focus {
    box-shadow: inset 0 3px 5px rgba(0, 0, 0, .125);
    border: 2px solid #ccc;
    background: #f9f8f8;
}

.store-head .bt-info .btn-group .btn.active:focus {
    background: #e5e5e5;
    box-shadow: inset 0 3px 5px rgba(0, 0, 0, .125);
    border: 2px solid rgba(85, 85, 85, 0.55);
}

.fa-caret-down {
    position: absolute !important;
    top: -5px;
    right: 0;
}
.fa-caret-up {
    position: absolute !important;
    top: -17px;
    right: 0;
}
.featured_heading .pull-left{
    position: relative;
    padding-right: 19px;
}
.fa-last-i{
    top: -10px;
}
</style>
<!-- store section design -->
    <div class="container-fluid store-head">
        <div class="container">
            <div class="col-md-12">
            <input type="hidden" id="storeid" class="form-control" value="{$store.id}">
                <div class="col-md-12 con" id="dvPreview2" style="height:200px;overflow:hidden;position:relative;">
                    {if $store.banner != ''}
                    <div id="dvPreview3" style="height:500px;width:100%;position:absolute;">
                        <img src="{$config.url}/uploads/store/{$store.banner}" style="top:{$store.btop}px;left:{$store.bleft}px;position: absolute;" class="img-responsive bck-img banimg">
                    </div>
                    {/if}
                    <input type="hidden" name="bleft" id="bleft">
                    <input type="hidden" name="btop" id="btop">
                    <input type="hidden" name="confurl" id="confurl" value=" {$config.url}">
                    <div class="col-md-12 img-info ah1">
                        <div class="col-sm-2 " id="dvPreview">{if  $store.logo != ''}
                            <img src="{$config.url}/uploads/store/{$store.logo}" style="max-width: 142px;max-height: 142px;height: 142px;width: 142px;    border-radius: 100%;" class="img-responsive" >{else}<img src="{$config.url}/images/stores/no-imgst.png" style="max-width: 142px;width: 142px;max-height: 142px;height: 142px;    border-radius: 100%;" class="img-responsive" >{/if}
                            <!--   <input name="store_image" class="input file-upload" type="file" style="opacity:0">
                            <button type="button" class="btn btn-default" onclick="triggerfile()">{$phrase.upload_logo}</button> -->
                            <span class="btn btn-default btn-file" onclick="triggerfile()">
                                Edit Image <input name="store_image" id="store_image" class="input file-upload weww" type="file" style="opacity:0">
                            </span>
                        </div>
                        <div class="col-sm-10 text-right" style="width:auto;float:right">
                            <div class="btn-group" >
                                <button type="button" class="btn btn-default">Revert</button>
                                <button type="button" class="btn btn-default  " onclick="addNew()">Add product</button>
                                <button type="button" class="btn btn-default" data-toggle="modal" data-target="#default_categories">Edit Categories</button>
                                <button type="button" class="btn btn-default" onclick="window.location='{$config.url}/stores/view/{$store.id}'">View Store</button>
                                <button type="button"  onclick="window.location='{$config.url}/stores/dashboard/{$store.id}'" class="btn btn-default">Dashboard</button>
                                <!-- <button type="button" onclick="window.location='{$config.url}/stores/show_adwords/{$store.id}'" class="btn btn-default">Advertising</button> -->
                                <div class="btn-group">
                                    <button type="button" class="btn btn-default dropdown-toggle buttonchange"  aria-haspopup="true" aria-expanded="false"> Edit Banner <span class="caret"></span> </button>
                                    <ul class="bannerdrop ">
                                        <div class="ah3">
                                            <span class="upban"  onclick="triggerfile2()"> Upload New Image
                                                <input name="store_banner_image" id="store_banner_image" class="input file-upload" type="file" style="opacity:0">
                                            </span>
                                        </div>
                                        <li class ="bannerli bannerrepos" {if $store.banner != ''} style="display: block;" {/if}><a >Reposition</a></li>
                                        <li class ="bannerli bannerrem" {if $store.banner != ''} style="display: block;" {/if}><a >Remove</a></li>
                                    </ul>
                                </div>
                            </div>
                            <div class="col-md-12 social" style="width:auto;">
                                <div class="btn-group dropup">
                                    <div class="gry_but save_reposition blcok" style="display: none;">
                                        <span>Save Banner</span>
                                    </div>
                                    <div id="addid_social" style="display: none;">
                                        <span class='add_social' onclick="submit_url($('#urlnames').val())">
                                            <input id="urlnames" value="" type="hidden">
                                        </span>
                                        <input id="socialnet" placeholder="Please enter the URL" style="" value="" type="text">
                                    </div>
                                    <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">Social
                                        <span class="caret"></span>
                                    </button>
                                    <ul class="dropdown-menu">
                                        <li><a>Facebook  <span class="sociallink fadd" id="facebook" {if $store.facebook == ''} style="display: block;"{/if}>Add</span><span class="removelink  frem" id="facebook" {if $store.facebook != ''} style="display: block;"{/if}>Remove</span></a></li>
                                        <li><a>Twitter  <span class="sociallink tadd" id="twitter" {if $store.twitter == ''} style="display: block;"{/if}>Add</span><span class="removelink trem" id="twitter" {if $store.twitter != ''} style="display: block;"{/if}>Remove</a></li>
                                        <li><a>Google+ <span class="sociallink gadd" id="google" {if $store.google == ''} style="display: block;"{/if}>Add</span><span class="removelink grem" id="google" {if $store.google != ''} style="display: block;"{/if}>Remove</a></li>
                                        <li><a>Web <span class="sociallink wadd" id="website" {if $store.website == ''} style="display: block;"{/if}>Add</span><span class="removelink wrem" id="website" {if $store.website != ''} style="display: block;"{/if}>Remove</a></li>
                                    </ul>
                                    <div id="fac_id" {if $store.facebook != ''} style="display: block;" {/if}>
                                        <a href="{$store.facebook}" class="wedn" target="_blank">
                                            <span class="gry_but edit_mode viewbt">
                                                <span>
                                                    <span style="background:url(/images/home/faceboo_new.png) no-repeat; width:0px; height:0px; position:relative; top:-4px; left:5px;"></span>
                                                </span>
                                            </span>
                                        </a>
                                    </div>
                                    <div id="twi_id" {if $store.twitter != ''} style="display: block;" {/if}>
                                        <a href="{$store.twitter}" class="wedn" target="_blank">
                                            <span class="gry_but edit_mode viewbt">
                                                <span>
                                                    <span style="background:url(/images/home/twitt_new.png) no-repeat; width:22px; height:3px; position:relative; top:-4px; left:1px;"></span>
                                                </span>
                                            </span>
                                        </a>
                                    </div>
                                    <div id="goo_id" {if $store.google != ''} style="display: block;" {/if}>
                                        <a href="{$store.google}" class="wedn" target="_blank">
                                            <span class="gry_but edit_mode viewbt">
                                                <span>
                                                    <span style="background: transparent url(/images/home/google_plus.png) no-repeat scroll 0% 0%; height: 2px; position: relative; top: -1px; left: 0px; width: 4px;"></span>
                                                </span>
                                            </span>
                                        </a>
                                    </div>
                                    <div id="web_id" {if $store.website != ''} style="display: block;" {/if}>
                                        <a href="{$store.website}">
                                            <span class="gry_but edit_mode viewbt">
                                                <span>
                                                    <span style="background:url(/images/home/web_icon.png) no-repeat; width:18px; height:2px; position:relative; top:-3px; left:0px;"></span>
                                                </span>
                                            </span>
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-12 bt-info" max-prod="" >
                    <div class="col-sm-12">
                        <div class="col-sm-6 padlef0">
                            <div class="btn-group added_categories" attr-selected-cat='{$store.selected_category}'>
                            </div>
                            <select class="selected_categories" style="display:none">
                                {foreach $allStoreCategory as $key => $val}
                                    <option value="{$val.id}" parentid='{$val.parent_id}'>{$val.name}</option>
                                {/foreach}
                            </select>
                        </div>
                        <div class="col-sm-3 padlef0">
                            <div class="icon-addon addon-sm">
                                <input type="text" placeholder="Add products to your store" class="form-control" id="stsearch" onkeyup="addProducts();" onclick="addProducts();">
                                <label for="stsearch" class="fa fa-search"></label>
                            </div>
                        </div>
                        <div class="col-sm-3 padlef0">
                            <div class="icon-addon addon-sm">
                                <input type="text" placeholder="store search" class="form-control" id="ssearch">
                                <label for="ssearch" class="fa fa-search"></label>
                            </div>
                        </div>
                    </div>
                    <div class="col-sm-12">
                        <div class="flexContainer">
                            <div class="clearfix">
                                <input type="text" id="storename" class="form-control" value="{$store.name}">
                                <button type="submit" class="storename">Save</button>
                            </div>
                            <div class="clearfix">
                                <textarea type="text" id="storedesc" class="form-control"> {$store.description} </textarea>
                                <button type="submit" class="storedesc">Save</i></button>
                            </div>
                            <div class="clearfix">
                                <label> Tags</label>
                                <input type="text" id="aboutus" class="form-control" value="{$store.aboutus}">
                                <input type="hidden" id="aboutushid" class="form-control" value="{$store.aboutus}">
                                <button type="submit" class="about">Save</button>
                            </div>
                            <div class="clearfix">
                                <label> Store&nbsp;URL </label>
                                <span class="homepageres"> {$config.url}/stores/</span>
                                <input type="hidden" id="url" value="{$config.url}">
                                <input type="text" id="homename" class="form-control" value="{$store.homepage}">
                                <input type="hidden" id="homenamehid" class="form-control" value="{$store.homepage}">
                                <button type="submit" class="homepage">Save</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="container store-inner">
        <div class="viewaddproducts">
           <div class="col-md-12 bestseller_block ">
                <div class="panel panel-default">
                    <div class="panel-heading clearfix featured_heading" style="font-weight: bold;">
                        <div class="pull-left ftnclr"> Featured Products  </div>
                        <div class="pull-right">
                            <div class="btn-group" data-toggle="buttons">
                                <button type="button" class="btn btn-default save_forder">Save Order </button>
                                <button type="button" class="btn btn-default unfeature_selected">Unfeature Selected</button>
                            </div>
                        </div>
                    </div>
                    <div class="panel-body col-md-12 owldemosort owldemosort2" id="owldemo5">
                        {foreach $storeFProducts as $key => $val}
                            {if ($val.market_status != 'removed' && $loged.userid == $val.user_id) || ($loged.userid != $val.user_id && $val.market_status == 'open')}
                            <div class="col-md-3" attr-product-id="{$val.id}" attr-pcid="{$val.parent_category_id}">
                                {if $val.market_status != 'open'}
                                <div class="pro_item pointer_cur clearfix " title="View Product" style="cursor:not-allowed;">
                                {/if}
                                {if $val.market_status == 'open'}
                                <div class="pro_item pointer_cur clearfix" title="View Product" atr-pid="{$val.id}" atr-sid="{$store.id}">
                                {/if}
                                    <div class="text-right whsz" >
                                        <div class="checkbox">
                                            <label>
                                                <input type="checkbox" class="product_id" value="{$val.id}">
                                            </label>
                                        </div>
                                    </div>
                                    <div class="img-closed">

                                        {if $val.market_status == 'draft'}
                                           <img src="/images/draft.png">
                                        {/if}
                                        {if $val.market_status == 'sold'}
                                           <img src="/images/sold.png">
                                        {/if}
                                        {if $val.market_status == 'moderate'}
                                           <img src="/images/waiting.png">
                                        {/if}
                                        {if $val.market_status == 'open'}
                                            {if $val.feature == '1'}
                                                <img src="/images/Features-store.png">
                                            {/if}
                                        {/if}
                                    </div>
                                    <div class="block1_img">
                                        {if !$val.img1}
                                            <img src="{$config.url}/images/stores/no-imgst.png" alt="Image" class="img-responsive ">
                                        {else if $val.img1 != '' && $val.img1 != null && $val.img1 != 'null'}
                                            <img src="{$config.url}/uploads/product/{$val.img1}"  alt="Image" class="img-responsive">
                                        {/if}
                                    </div>
                                    <div class="clearfix"></div>
                                    <div class="col-md-12"  style='font-size:12px !important'>
                                        <div class="pro_head">
                                        {$commonfunction.shorten($val.title,15)}
                                        </div>
                                        <div class="pro-des">
                                        {$commonfunction.shorten($val.description,20)}
                                        </div>
                                    </div>
                                </div>
                            </div>
                            {/if}
                        {/foreach}
                    </div>
                </div>
            </div>
            <div class="product_append_div">
            </div>
            <div class="temporder">
                {foreach $selectStoreAllOrder as $key => $val}
                    <div class="order_details" order-catid='{$val.category_id}' order-pro-ids='{$val.project_order_ids}'></div>
                {/foreach}
            </div>
            <div class="tempappend" style="display:none";>
                {foreach $storeAllCategory as $key => $val}
                    {if ($val.market_status != 'removed' && $loged.userid == $val.user_id) || ($loged.userid != $val.user_id && $val.market_status == 'open')}
                    <div class="col-md-3" attr-product-id="{$val.id}" attr-pcat-id="{$val.parent_category_id}">
                        {if $val.market_status != 'open'}
                        <div class="pro_item pointer_cur clearfix" style="cursor:not-allowed;"  title="View Product" >
                        {/if}
                        {if $val.market_status == 'open'}
                        <div class="pro_item pointer_cur clearfix" title="View Product" atr-pid="{$val.id}" atr-sid="{$store.id}">
                        {/if}
                            <div class="text-right whsz" >
                                <div class="checkbox">
                                    <label>
                                        <input type="checkbox" class="product_id" value="{$val.id}">
                                    </label>
                                </div>
                            </div>
                            <div class="img-closed">
                                {if $val.market_status == 'closed'}
                                   <img src="/images/closed.png">
                                {/if}
                                {if $val.market_status == 'draft'}
                                   <img src="/images/draft.png">
                                {/if}
                                {if $val.market_status == 'sold'}
                                   <img src="/images/sold.png">
                                {/if}
                                {if $val.market_status == 'moderate'}
                                   <img src="/images/waiting.png">
                                {/if}
                                {if $val.market_status == 'open'}
                                    {if $val.feature == '1'}
                                        <img src="/images/Features-store.png">
                                    {/if}
                                {/if}
                            </div>
                            <div class="block1_img">
                                {if !$val.img1}
                                    <img src="{$config.url}/images/stores/no-imgst.png" alt="Image" class="img-responsive ">
                                {else if $val.img1 != '' && $val.img1 != null && $val.img1 != 'null'}
                                    <img src="{$config.url}/uploads/product/{$val.img1}"  alt="Image" class="img-responsive">
                                {/if}
                            </div>
                            <div class="clearfix"></div>
                            <div class="col-md-12"  style='font-size:12px !important'>
                                <div class="pro_head">
                                {$commonfunction.shorten($val.title,15)}
                                </div>
                                <div class="pro-des">
                                {$commonfunction.shorten($val.description,20)}
                                </div>
                            </div>
                        </div>
                    </div>
                    {/if}
                {/foreach}
            </div>
        </div>
        <div class="view_add_products">

        </div>
        <div id="default_categories" class="modal fade" role="dialog">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h4 class="modal-title">Store Categories</h4>
                    </div>
                    <div class="modal-body row defaultcategories" attr-allcat-id="{$selecteStoreCategory[0].storecategory_ids}">
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default save_edit_categories">Save</button>
                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>
        <div id="save_alert" class="modal fade"role="dialog">
            <div class="modal-dialog">
                <div class="modal-content  col-md-4  col-md-offset-4" style="height: 100px;margin-top: 35%;">
                    <div class="modal-body msg_text text-center h4" style="min-height: 50px;margin-top: 25px;">
                    </div>
                </div>
            </div>
        </div>
        <div id="show_category_pay" class="modal fade" role="dialog">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-body text-center div_content" style="min-height: 76px;">
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <input type="hidden" id="allocatedcount" value="1">
    <input type="hidden" id="allocatedcountCat" value="5">

<script type="text/javascript">
	$(document).ready(function () {
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
                $('.loader_div').hide();
            } else {
                $('.loader_div').hide();
            }
        });
        if($('[attr-allcat-id]').length > 0) {
            var selected_ids = $('[attr-allcat-id]').attr('attr-allcat-id');
            selected_ids = selected_ids.split(",");
            if(selected_ids.length > 0) {
                var html = '';
                $('.selected_categories option').each(function() {
                    if(Number($(this).attr('parentid')) == 0) {
                        if(selected_ids.indexOf($(this).val()) > -1) {
                            var checked = '';
                            var selected_cat = $('[attr-selected-cat]').attr('attr-selected-cat');
                                selected_cat = selected_cat.split(",");
                            if(selected_cat.indexOf($(this).val()) > -1) {
                                checked = 'checked="checked"';
                            }
                            html += '<div class="col-lg-6">\
                               <div class="input-group" style="padding-bottom:5px;">\
                                   <span class="input-group-addon">\
                                       <input type="checkbox" class="selected_stores" value="'+$(this).val()+'" '+checked+'>\
                                   </span>\
                                   <span class="form-control">'+$(this).html()+'<span>\
                                </div>\
                            </div>';
                        }
                    }
                });
                if(html == '') {
                    $('.defaultcategories').html('No categories');
                } else {
                    html = '<div class="col-lg-4 col-lg-offset-4">\
                       <div class="input-group" style="padding-bottom:5px;">\
                           <span class="input-group-addon">\
                               <input type="checkbox" class="selected_stores" value="0">\
                           </span>\
                           <span class="form-control">Select All<span>\
                        </div>\
                    </div>'+html;
                    $('.defaultcategories').html(html);
                }
            }
        }
        if($('[attr-selected-cat]').length > 0) {
            var selected_ids = $('[attr-selected-cat]').attr('attr-selected-cat');
                selected_ids = selected_ids.split(",");
            if(selected_ids.length > 0) {
                var temp_html   = '';
                    for (var i = 0; i < selected_ids.length; i++) {
                        if (selected_ids[i] != '') {
                            temp_html += '<div class="col-md-12 bestseller_block">\
                                <div class="panel panel-default">\
                                    <div class="panel-heading clearfix featured_heading" style="font-weight: bold;">\
                                        <div class="pull-left ">\
                                            <span class="category_title ftnclr">'+selected_ids[i]+'</span> \
                                            <i class="fa fa-caret-down"></i><i class="fa fa-caret-up"></i>\
                                        </div>\
                                        <div class="pull-right">\
                                            <div class="btn-group" data-toggle="buttons">\
                                                <button type="button" class="btn btn-default save_order" value="'+selected_ids[i]+'">Save Order </button>\
                                                <button type="button" class="btn btn-default feature_selected"  value="'+selected_ids[i]+'">Feature Selected</button>\
                                                <button type="button" class="btn btn-default unstock_selected"  value="'+selected_ids[i]+'">Unstock Selected</button>\
                                            </div>\
                                        </div>\
                                    </div>\
                                    <div class="panel-body" catid="'+selected_ids[i]+'">\
                                    </div>\
                                </div>\
                            </div>';
                        }
                    }
                $('.product_append_div').html(temp_html);

                $('[catid]').each(function () {
                    var tempval = $('[attr-pcat-id="'+$(this).attr('catid')+'"]').detach();
                    $(this).html(tempval);
                });
                $('[attr-pcid]').each(function () {
                    var pcid = $(this).attr('attr-pcid');
                    if (selected_ids.indexOf(pcid) < 0) {
                        $(this).remove();
                    }
                });
                $('.bestseller_block .panel-body').each(function () {
                    if($(this).find('[attr-product-id]').length == 0) {
                        $(this).prev().find('.btn-group .btn').attr('disabled','disabled').css('cursor','none');
                        $(this).html('<div class="text-center  ftn600 ftn18">No products</div>');
                    } else {
                        $(this).sortable();
                        $(this).disableSelection();
                    }
                });
                if($('.order_details').length > 0) {
                    $('.order_details').each(function () {
                        var ids = $(this).attr('order-pro-ids');
                            ids = ids.split(',');
                        if($(this).attr('order-catid') == 0) {
                            var html = '';
                            for(pid in ids) {
                                html = $('#owldemo5 [attr-product-id="'+ids[pid]+'"]').detach();
                                $('#owldemo5').append(html);
                            }
                        } else if($(this).attr('order-catid') != 0){
                            var cid  = $(this).attr('order-catid');
                            var html = '';
                            for(pid in ids) {
                                html = $('[catid="'+cid+'"] [attr-product-id="'+ids[pid]+'"]').detach();
                                $('[catid="'+cid+'"]').append(html);
                            }
                        }
                    });
                }
                $('.tempappend').remove();
            }
        }


        $(".category_title").each(function () {
            var cat = Number($(this).text());
            var title = '';
            $('.selected_categories option').each(function() {
                if(Number($(this).val()) == cat) {
                    title = $(this).text();
                }
            });
            if(title.trim() == '') {
                $(this).closest('.bestseller_block').remove();
            } else {
                $(this).text(title);
            }
        });

        if($('[attr-selected-cat]').length > 0) {
            var selected_ids = $('[attr-selected-cat]').attr('attr-selected-cat');
                selected_ids = selected_ids.split(",");
            if(selected_ids.length > 0) {
                var html = '';
                $('.selected_categories option').each(function() {
                    if(Number($(this).attr('parentid')) == 0) {
                        if(selected_ids.indexOf($(this).val()) > -1) {
                            html += '<button type="button" class="btn btn-default" value='+$(this).val()+'>'+$(this).html()+'</button>';
                        }
                    }
                });
                if(html == '') {
                    $('.added_categories').html('No categories');
                } else {
                    $('.added_categories').html('<button type="button" class="btn btn-default" value="0">All</button>'+html);
                }
            //    $('.selected_categories').remove();
            }
        }
        $('body').on('click', '.save_edit_categories', function () {
            var edit_cat_ids  = [];
            var subcount      = setMaxCat();
            var defaultcount  = '{$config.freesubscription.category}';
            var max_cat       = Number(defaultcount) + Number(subcount);
            $('.selected_stores').each(function () {
                if($(this).is(':checked') == true) {
                    if($(this).val() != 0) {
                        edit_cat_ids.push($(this).val())
                    }
                }
            });
            if(edit_cat_ids.length > 0 && edit_cat_ids.length <= max_cat) {
                edit_cat_ids = edit_cat_ids.toString();
                var param = "default_ids="+edit_cat_ids+"&id={$store.id}";
                $.ajax({
                    type: "POST",
                    url : "/stores/updateStoreCatEdit",
                    data: param,
                    dataType: "json",
                    success:function(data) {
                        if(data.result == 'success') {
                            location.href='{$config.url}/stores/edit/{$store.id}';
                        }
                    }
                });
            } else {
                if(edit_cat_ids.length > max_cat) {
                    $('#default_categories').modal('hide');
                    // $('.div_content').html('Sorry you can able add maximum '+max_cat+' categories for free.</b>\
                    // If you want to add more categories, please <a href="{$config.url}/stores/addcat/getpay/{$store.id}">click here</a>');
                    $('.div_content').html('Sorry you can able add maximum {$config.freesubscription.category} categories for free.</b>\
                    If you want to add more categories, please <a href="{$config.url}/stores/recurringpayment/{$store.id}">click here</a>');
                    $('#show_category_pay').modal('show');
                } else {
                    alert('Please select categories to add');
                }
            }
        }).on('click', '.added_categories button',function() {
            if($(this).val() == 0) {
                if($(this).hasClass('active') == true) {
                    $('.added_categories button').removeClass('active');
                } else {
                    $('.added_categories button').addClass('active');
                }
            } else {
                if($(this).hasClass('active') == true) {
                    $(this).removeClass('active');
                } else {
                    $(this).addClass('active');
                }
                var i = 0;
                $('.added_categories button').each(function () {
                    if($(this).hasClass('active') == true && $(this).val() != 0) {
                        i++;
                    }
                });
                if(i == $('.added_categories button').length-1) {
                    $('.added_categories button').addClass('active');
                } else {
                    $('.added_categories button').first().removeClass('active');
                }
            }
            addProducts();
        }).on('keyup', '#ssearch', function () {
            var s_txt = $(this).val().trim().toLowerCase();
            if(s_txt != '') {
                $('.pro_head').each(function() {
                    var val = $(this).text().trim().toLowerCase();
                    if(val.indexOf(s_txt) > -1) {
                        $(this).closest('[attr-product-id]').css('display','block');
                    } else {
                        $(this).closest('[attr-product-id]').css('display','none');
                    }
                });
            } else {
                $('[attr-product-id]').css('display','block');
            }
        });
        $( "#owldemo5" ).sortable();
        $( "#owldemo5" ).disableSelection();

        var spinner = '<i class="fa fa-spinner fa-spin" style="font-size:14px"></i>';
        $('.main_wrapper').each(function() {
            $(this).prev().remove();
            $(this).attr('class','');
            $(this).children().attr('class','');
        });

        $('body').on('click', '.feature_selected', function() {
            var cat_id       = $(this).val();
            var selected_ids = [];
            $('[catid="'+cat_id+'"] .product_id').each(function() {
                if($(this).is(':checked') == true) {
                    selected_ids.push($(this).val());
                }
            });
            if(selected_ids.length > 0) {
                var param = "ids="+selected_ids+"&featured=1";
                var url = 'updateFeature';
                sendProductData(param,url);
            } else {
                alert('Please select product to make featured');
            }
        }).on('click', '.unfeature_selected', function() {
            var selected_ids = [];
            $('#owldemo5 .product_id').each(function() {
                if($(this).is(':checked') == true) {
                    selected_ids.push($(this).val());
                }
            });
            if(selected_ids.length > 0) {
                var param = "ids="+selected_ids+"&featured=2";
                var url = 'updateFeature';
                sendProductData(param,url);
            } else {
                alert('Please select product to make Unfeatured');
            }
        }).on('click', '.unstock_selected', function() {
            var cat_id       = $(this).val();
            var selected_ids = [];
            $('[catid="'+cat_id+'"] .product_id').each(function() {
                if($(this).is(':checked') == true) {
                    selected_ids.push($(this).val());
                }
            });
            if(selected_ids.length > 0) {
                var param = "ids="+selected_ids+"&sid={$store.id}";
                var url = 'updateUnstock';
                sendProductData(param, url);
            } else {
                alert('Please select product to make Unstock');
            }
        }).on('click', '.save_order', function() {
            var cat_id       = $(this).val();
            var selected_ids = [];
            $('[catid="'+cat_id+'"] .product_id').each(function() {
                selected_ids.push($(this).val());
            });
            if(selected_ids.length > 0) {
                var param = "ids="+selected_ids+"&sid={$store.id}&cid="+cat_id+"";
                var url = 'updateOrder';
                sendProductData(param, url);
            } else {
                alert('Please change product to save order');
            }
        }).on('click', '.save_forder', function() {
            var selected_ids = [];
            $('#owldemo5 .product_id').each(function() {
                selected_ids.push($(this).val());
            });
            if(selected_ids.length > 0) {
                var param = "ids="+selected_ids+"&sid={$store.id}&cid=0";
                var url = 'updateOrder';
                sendProductData(param, url);
            } else {
                alert('Please change product to save order');
            }
        }).on('click', '.product_id, .pro_item',function(event){
            if($(this).attr('class') == 'product_id' || $(this).css('cursor') == 'not-allowed') {
                event.stopPropagation();
            } else {
                location.href='{$config.url}/product/view/'+$(this).attr('atr-pid')+'/'+$(this).attr('atr-sid')+'';
            }
        }).on('click', '.fa-caret-down', function() {
            var html = $(this).closest('.bestseller_block');
            if(html.next().html() != undefined) {
                html.next('.bestseller_block').after(html.detach());
                var pos = html.offset().top;
                $('html body').animate({ scrollTop: pos}, 500);
                arrowCheckIn();
                storeCatOrder();
            }
        }).on('click', '.fa-caret-up', function() {
            var html = $(this).closest('.bestseller_block');
            if(html.prev().html() != undefined) {
                html.prev('.bestseller_block').before(html.detach());
                var pos = html.offset().top;
                $('html body').animate({ scrollTop: pos}, 500);
                arrowCheckIn();
                storeCatOrder();
            }
        });
        arrowCheckIn();
        $(".storename").click(function() {
            var storeid = $('#storeid').val();
            var storname = $('#storename').val();
            if (storname.trim() == '') {
                alert('Please enter Store title to save');
                return false;
            }
            if($(this).children('.fa-spinner').length == 0) {
                var labelname = $(this).html();
                $(this).html(labelname+spinner);
            }
            var myKey = { storeid : storeid, storname : storname};
            $.ajax({
                type:"POST",
                url:"/stores/storename",
                data:myKey,
                dataType:"json",
                success:function(data) {
                    if(data.result == 'success') {
                        $(".storename").html(labelname);
                        displayMsg();
                    }
                }
            });
        });
        $( ".storedesc" ).click(function() {
            var storeid     = $('#storeid').val();
            var storedesc   = $('#storedesc').val();
            if(storedesc.trim() == '') {
                alert('Please enter description to save');
                return false;
            }
            if($(this).children('.fa-spinner').length == 0) {
                var labelname = $(this).html();
                $(this).html(labelname+spinner);
            }
            var myKey = { storeid : storeid, storedesc : storedesc};
            $.ajax({
                type    : "POST",
                url     : "/stores/storedesc",
                data    : myKey,
                dataType: "json",
                success : function(data) {
                    if(data.result == 'success') {
                        $(".storedesc").html(labelname);
                        displayMsg();
                    }
                }
            });
        });
        $( ".sociallink" ).click(function() {
            $('.save_reposition').fadeOut();
            $('#addid_social').fadeIn();
            var id = $(this).attr('id');
            $('#urlnames').val(id);
        });
        $( ".removelink" ).click(function() {
            var storeid = $('#storeid').val();
            var id      = $(this).attr('id');
            var myKey   = {storeid : storeid,  urlname : id};
            $.ajax({
                type    : "POST",
                url     : "/stores/storesocialremove",
                data    : myKey,
                dataType: "json",
                success : function(data) {
                    if(data.result == 'success' && data.url == 'facebook') {
                        $('#fac_id').fadeOut();
                        $('.frem').fadeOut();
                        $('.fadd').fadeIn();
                    }
                    if(data.result == 'success' && data.url == 'twitter') {
                        $('#twi_id').fadeOut();
                        $('.trem').fadeOut();
                        $('.tadd').fadeIn();
                    }
                    if(data.result == 'success' && data.url == 'google') {
                        $('#goo_id').fadeOut();
                        $('.grem').fadeOut();
                        $('.gadd').fadeIn();
                    }
                    if(data.result == 'success' && data.url == 'website') {
                        $('#web_id').fadeOut();
                        $('.wrem').fadeOut();
                        $('.wadd').fadeIn();
                    }
                }
            });
        });
        $(".buttonchange").click(function(){
            $(".bannerdrop").toggle();
        });
        $( ".bannerrem" ).click(function() {
            var storeid = $('#storeid').val();
            var myKey = {  storeid : storeid};
            $.ajax({
                type:"POST",
                url:"/stores/storebannerremove",
                data:myKey,
                dataType:"json",
                success:function(data) {
                    $(".bannerdrop").toggle();
                    $(".banimg").attr("src","");
                    $('.bannerli').hide();
                }
            });
        });
        $(".bannerrepos" ).click(function() {
            $(".bannerdrop").toggle();
            $('#addid_social').fadeOut();
            $(".save_reposition").fadeIn();
            $('.banimg').draggable({
                containment: "#dvPreview3",
                disabled: false,
                scroll: false,
                drag: function(){
                    var offset = $(this).position();
                    var xPos   = offset.left;
                    var yPos   = offset.top;
                    $('#bleft').val(xPos);
                    $('#btop').val(yPos);
                }
            });
            $('.banimg').css('cursor','move');
        });
        $( ".save_reposition" ).click(function() {
            var storeid = $('#storeid').val();
            var left = $('#bleft').val();
            var top =  $('#btop').val();
            var myKey = {  storeid : storeid,left:left,top:top};
            $.ajax({
                type:"POST",
                url:"/stores/storebannerposition",
                data:myKey,
                dataType:"json",
                success:function(data) {
                    if(data.result == 'success') {
                        $('.save_reposition').fadeOut();
                        $('.banimg').draggable({ disabled: true });
                        $('.banimg').css('cursor','initial');
                        displayMsg();
                    }
                }
            });
        });

        $( ".homepage" ).click(function() {
            var storeid = $('#storeid').val();
            var homename = $('#homename').val();
            var url = $('#url').val();
            if(homename.trim() == '') {
                alert('Please enter Store URL to save');
                return false;
                var homename = $('#homenamehid').val();
            }
            if($(this).children('.fa-spinner').length == 0) {
                var labelname = $(this).html();
                $(this).html(labelname+spinner);
            }
            var myKey = {storeid : storeid,homename:homename};
            $.ajax({
                type:"POST",
                url:"/stores/storehomename",
                data:myKey,
                dataType:"json",
                success:function(data) {
                    if(data.result == 'success') {
                        $(".homepage").html(labelname);
                        $('.homepageres').text(url+'/stores/'+homename);
                        $('#homenamehid').val(homename);
                        displayMsg();
                    }
                }
            });
        });
        $( ".about" ).click(function() {
            var storeid = $('#storeid').val();
            var aboutus = $('#aboutus').val();
            if(aboutus.trim() == '') {
                alert('Please enter tags to save');
                return false;
                var aboutus = $('#aboutushid').val();
            }
            if($(this).children('.fa-spinner').length == 0) {
                var labelname = $(this).html();
                $(this).html(labelname+spinner);
            }
            var myKey = {  storeid : storeid,aboutus:aboutus};
            $.ajax({
                type:"POST",
                url:"/stores/storeaboutus",
                data:myKey,
                dataType:"json",
                success:function(data) {
                    if(data.result == 'success') {
                        $(".about").html(labelname);
                        $('#aboutus').val(aboutus);
                        $('#aboutushid').val(aboutus);
                        displayMsg();
                    }
                }
            });
        });
        var len  = $('.product_append_div [attr-product-id]').length;
        $('[max-prod]').attr('max-prod', len);
    });

    function setMaxPro() {
        var count = 0;
        $.ajax({
            type    : "POST",
            url     : "/stores/getsubcount",
            data    : 'sid={$store.id}&type=product',
            async   : false,
            dataType: "json",
            success : function(data) {
                count = data.product;
            }
        });
        return count;
    }
    function setMaxCat() {
        var count = 0;
        $.ajax({
            type    : "POST",
            url     : "/stores/getsubcount",
            data    : 'sid={$store.id}&type=category',
            async   : false,
            dataType: "json",
            success : function(data) {
                count = data.category;
            }
        });
        return count;
    }
    function view_store() {
         var storeid = $('#storeid').val();
         window.location='{$config.url}/stores/view/'+storeid;
    }

    function sendProductData(param, url) {
        $.ajax({
            url     : '/stores/'+url+'',
            type    : 'POST',
            data    : param,
            dataType: "json",
            success : function(data) {
                if(data.result = 'success') {
                    location.href='{$config.url}/stores/edit/{$store.id}';
                } else {
                    alert('Some unknown error on updating your product');
                }
            }
        });
    }

    function onvll() {
        var pro_len = $('[max-prod]').attr('max-prod');
        var pid     = new Array();
        var storeid = $('#storeid').val();
        var confurl = $('#confurl').val();
        cnt=0;

        $("input[name='product[]']:checked").each(function() {
            pid.push($(this).val());
            cnt++;
        });
        pro_len           = Number(pro_len)+Number(cnt);
        var subcount      = setMaxPro();
        var defaultcount  = '{$config.freesubscription.product}';
        var allc          = Number(defaultcount) + Number(subcount);

        if(Number(pro_len) < Number(allc)) {
            var myKey = 'storeid='+storeid+'&pids='+pid+'&cnt='+cnt;
            $.ajax({
                type    : "POST",
                url     : "/stores/addproduct_store",
                data    : myKey,
                async   : true,
                dataType: "json",
                success : function(data) {
                    window.location=confurl+'/stores/view/'+storeid;
                }
            });
        } else {
            $('.div_content').html('You reached maxmimum products in your store\
            , Press <a href="{$config.url}/stores/recurringpayment/{$store.id}">click here</a> to do subscription for add more products');
            $('#show_category_pay').modal('show');
        }
    }

    function addProducts() {
        var cids = [];
        $('.added_categories button').each(function () {
            if($(this).hasClass('active') == true) {
                cids.push($(this).val());
            }
        });
        if (cids.length > 0) {
            cids = cids;
        } else {
            $('.added_categories button').each(function () {
                cids.push($(this).val());
            });
            cids = cids;
        }
        var txt = (typeof($('#stsearch').val()) == 'undefined') ? '' : $('#stsearch').val();
        $.ajax({
            type    : 'GET',
            url     : '/stores/add/{$store.id}/'+cids+'/'+txt+'',
            dataType : 'JSON',
            success : function(data) {
                $('.viewaddproducts').hide();
                $('.view_add_products').html(data.html);
                // $('#storeModal').modal('show');
                addFProducts();
            }
        });
    }
    function addFProducts() {
        $.ajax({
            type    : 'GET',
            url     : '/stores/feature/{$store.id}',
            success : function(data) {
                $('.carousel_content').html(data);
            }
        });
    }
    function on_off_c(obj,k) {
        if($("."+k).attr("checked") == 'checked') {
            $("."+k).removeAttr("checked");
            $(obj).addClass("off");
            $(obj).removeClass("on");
        } else {
            $("."+k).attr("checked","checked")
            $(obj).addClass("on");
            $(obj).removeClass("off");
        }
    }
    function isUrl(s) {
    	var regexp = /(ftp|http|https):\/\/(\w+:{0,1}\w*@)?(\S+)(:[0-9]+)?(\/|\/([\w#!:.?+=&%@!\-\/]))?/
    	return regexp.test(s);
    }
    function submit_url(urlname){
        var socialname   = $('#socialnet').val();
        var storeid      = $('#storeid').val();
        var validate     = isUrl(socialname.trim());
        if(socialname.trim() == '') {
            alert("Please enter the URL");
            return false;
        }
        if(validate == false) {
            alert("Please enter the valid URL");
            return false;
        }
        var myKey = {  storeid : storeid, socialname : socialname, urlname : urlname};
        $.ajax({
            type    :"POST",
            url     :"/stores/storesocial",
            data    :myKey,
            dataType:"json",
            success :function(data) {
                $('#urlnames').val('');
                $('#socialnet').val('');
                $('#addid_social').fadeOut();
                if(data.result == 'success' && data.url == 'facebook') {
                    $('#fac_id').fadeIn();
                    $('#fac_id a').attr('href',socialname);
                    $('.fadd').fadeOut();
                    $('.frem').fadeIn();
                }
                if(data.result == 'success' && data.url == 'twitter') {
                    $('#twi_id').fadeIn();
                    $('#twi_id a').attr('href',socialname);
                    $('.tadd').fadeOut();
                    $('.trem').fadeIn();
                }
                if(data.result == 'success' && data.url == 'google') {
                    $('#goo_id').fadeIn();
                    $('#goo_id a').attr('href',socialname);
                    $('.gadd').fadeOut();
                    $('.grem').fadeIn();
                }
                if(data.result == 'success' && data.url == 'website') {
                    $('#web_id').fadeIn();
                    $('#web_id a').attr('href',socialname);
                    $('.wadd').fadeOut();
                    $('.wrem').fadeIn();
                }
            }
        });
    }
    function displayMsg() {
        $('#save_alert').modal('show');
        $('#save_alert .msg_text').text('Saved !');
        setTimeout(function() {
            $('#save_alert').modal('hide');
        }, 1000);
    }
    function arrowCheckIn() {
        $('.fa').show().removeClass('fa-last-i');
        var cat_div = $('.product_append_div .bestseller_block');
        cat_div.first().find('.fa-caret-up').hide();
        cat_div.last().find('.fa-caret-down').hide();
        cat_div.first().find('.fa-caret-down').addClass('fa-last-i');
        cat_div.last().find('.fa-caret-up').addClass('fa-last-i');
    }
    function storeCatOrder() {
        var order_ids = [];
        $('.product_append_div .bestseller_block').each(function () {
            order_ids.push($(this).find('.panel-body').attr('catid'));
        });
        if(order_ids.length > 0) {
            var val = order_ids.toString();
            var param = "default_ids="+val+"&id={$store.id}";
            $.ajax({
                type     : "POST",
                url      : "/stores/updateStoreCatEdit",
                dataType : 'json',
                data     : param,
                success  : function(response) {
                    if(response.result != 'success') {
                        alert('Error on saving order please try again');
                    }
                }
            });
        }
    }
    function addNew() {
        var check = $('[max-prod]').attr('max-prod');
        var subcount      = setMaxPro();
        var defaultcount  = '{$config.freesubscription.product}';
        var allc          = Number(defaultcount) + Number(subcount);
        if(Number(check) < Number(allc)) {
            window.location='{$config.url}/product/post/{$store.id}'
        } else {
            $('.div_content').html('You reached maxmimum products in your store,\
            Press <a href="{$config.url}/stores/recurringpayment/{$store.id}">\
            click here</a> to do subscription for add more products');
            $('#show_category_pay').modal('show');
        }
    }
</script>
{include file="common/footer-1.tpl" nocache}
{include file="store/store-js.tpl" nocache}
