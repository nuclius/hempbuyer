{include file="common/header-1.tpl" nocache}
{include file="store/css-store.tpl" nocache}
<style media="screen">
.search-div {
    border: 2px solid #60aa3e;
    max-width: 100%;
    padding-top: 6px;
    padding-bottom: 0px;
    padding-right: 6px;
    padding-left: 6px;
    border-radius: 29px;
    margin-top: 20px; background: #fff;
}
.search-div div {
    padding: 7px;
    border: 1px solid #CCCCCC;
    border-radius: 29px;
    margin-right: 6px;
    display: inline-block;
    margin-bottom: 6px;
    position: relative;
    cursor: pointer;
    padding-right: 20px;
    -webkit-transition: all 2s ease;/* Safari 3.2+, Chrome */
    -moz-transition: all 2s ease;/* Firefox 4-15 */
    -o-transition: all 2s ease;/* Opera 10.5-12.00 */
    transition: all 2s ease;/* Firefox 16+, Opera 12.50+ */
}
.search-div div .glyphicon{
    position: absolute;
    margin-top: 9px;
    display:none;
}
.search-div div:hover span {
    display: inline-block;
}
.search-div input{
    height: 36px;
    border: none;
    margin-bottom: 6px;
    margin-left: 13px;
    width: 100px;
}
.search-div input:focus {
    outline: none;
    border: none;
}

.dropdown .dropdown-menu {
    top: 80%;
    min-width: 185px;
}
.dropdown:hover .dropdown-menu,dropdown:hover .dropdown-menu ul{
    display: block;
}

.dropdown .dropdown-toggle, .dropdown li a{
    cursor: pointer;
    color: #817f7f;
}
.dropdown-filter .dropdown{
    display: inline-block;
    padding: 6px;
}
.overflwscrl {
    overflow-y: scroll;
    max-height:230px;
}
</style>

<div class="container-fluid yr-store">
    <div class="storebox col-md-12 h3 nwftn text-center">
        {if Number($loguserid) == 0}
            Stores
        {else if Number($loguserid) > 0}
            Your Stores
        {/if}
    </div>
    <div class="col-md-12" style="margin-bottom:30px;">
        <div class="col-lg-6 col-md-6 col-lg-offset-3 col-md-offset-3 search-div">
            <input type="text" class="search-input" placeholder="Title and Tag">
        </div>
        <div class="col-lg-6 col-md-6 col-lg-offset-3 col-md-offset-3 dropdown-filter">
            <div class="dropdown">
                <span class="dropdown-toggle" type="button" data-hover="dropdown">
                    Categories
                    <span class="fa fa-angle-down" ></span>
                </span>
                <ul class="dropdown-menu overflwscrl categories">
                    {foreach $storeCategories as $key => $val}
                    <li><a attr-cid="{$val.id}">{$val.name}</a></li>
                    {/foreach}
                </ul>
            </div>
            <div class="dropdown">
                <span class="dropdown-toggle" type="button" data-hover="dropdown">
                    Location
                    <span class="fa fa-angle-down"></span>
                </span>
                <ul class="dropdown-menu overflwscrl location">
                    {foreach $countries as $key => $val}
                    {if $val.parent_id == 0}
                    <li><a attr-lid="{$val.id}">{$val.name}</a></li>
                    {/if}
                    {/foreach}
                </ul>
            </div>
            <div class="dropdown">
                <span class="dropdown-toggle" type="button" data-hover="dropdown">
                    Search by <span class='searchtypeval text-capitalize'>Store</span>
                    <span class="fa fa-angle-down"></span>
                </span>
                <ul class="dropdown-menu">
                    <li class='clicksearch'>
                        <a>Search by <span class='searchtypeval text-capitalize'>Product</span></a>
                    </li>
                </ul>
            </div>
            {if Number($loguserid) > 0}
                <div class="dropdown pull-right">
                    <span class="dropdown-toggle" style="color: #c00;" type="button" data-hover="dropdown">
                        Manage store
                        <span class="fa fa-angle-down"></span>
                    </span>
                    <ul class="dropdown-menu">
                        <li><a onclick="checkStores()">Create New Store</a></li>
                        <li><a href="{$config.url}/stores/show_adwords">Manage ads</a></li>
                        <li><a href="{$config.url}/stores/transaction">Transaction of sales</a></li>
                        <li><a href="{$config.url}/stores/subscriptionsetting">Settings</a></li>
                        {if $stores.length > 0}
                        <li><a href="{$config.url}/stores/allreports">Reports</a></li>
                        {/if}
                    </ul>
                </div>
            {/if}
        </div>
        <input type="hidden" class="searchtype" value='store'>
    </div>
</div>

<div class="container"> 

    <div class="storediv col-md-12">
        <div class="storebox col-md-12" style="min-height:10px;">
            <div class="h3 nwftn storeboxh" style="margin-left: 14px;">
                Sponsored Stores
            </div>
            {foreach $stores as $key => $val}
                {if $val.adstore == 1}
                <div class="col-md-3 pro-dv" >
                    <div class="pro_item pointer_cur clearfix " title="View Product"  onclick="location.href='{$config.url}/stores/view/{$val.id}';">
                        <div class="block1_img">
                            {if !$val.logo}
                                <img src="{$config.url}/images/stores/no-imgst.png" alt="Image" class="img-responsive ">
                            {else if $val.logo != '' && $val.logo != null && $val.logo != 'null'}
                                <img src="{$config.url}/uploads/store/{$val.logo}"  alt="Image" class="img-responsive">
                            {/if}
                        </div>
                        <div class="clearfix"></div>
                        <div class="col-md-12"  style='font-size:13px !important'>
                            <div class="pro_head">
                                {$commonfunction.shorten($val.name,15)}
                            </div>
                            <div class="pro-des">
                                {$commonfunction.shorten($val.description,30)}
                            </div>
                        </div>
                    </div>
                </div>
                {/if}
            {/foreach}
        </div>
        <div class="storebox col-md-12" style="min-height:230px;">
            <div class="h3 nwftn storeboxh" style="margin-left: 14px;">
                Other Stores
            </div>
            {foreach $stores as $key => $val}
                {if $val.adstore == 0}
                <div class="col-md-3 pro-dv"  >
                    <div class="pro_item pointer_cur clearfix " title="View Product"  onclick="location.href='{$config.url}/stores/view/{$val.id}';">
                        <div class="block1_img">
                            {if !$val.logo}
                                <img src="{$config.url}/images/stores/no-imgst.png" alt="Image" class="img-responsive ">
                            {else if $val.logo != '' && $val.logo != null && $val.logo != 'null'}
                                <img src="{$config.url}/uploads/store/{$val.logo}"  alt="Image" class="img-responsive">
                            {/if}
                        </div>
                        <div class="clearfix"></div>
                        <div class="col-md-12"  style='font-size:13px !important'>
                            <div class="pro_head">
                                {$commonfunction.shorten($val.name,15)}
                            </div>
                            <div class="pro-des">
                                {$commonfunction.shorten($val.description,30)}
                            </div>
                        </div>
                    </div>
                </div>
                {/if}
            {/foreach}
        </div>
        <div class="col-md-12 text-center">
            {if $stores.length <= 0}No stores are available{/if}
        </div>
        <div class="col-md-12">
            <div class="pull-right">
                {$pagination_html}
            </div>
        </div>
    </div>
    <input type="hidden" class="userid" value="{$loguserid}">
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
{include file="common/footer-1.tpl" nocache}
<script type="text/javascript">
    function showExist(ths) {
        $(ths).css('border','1px solid #000');
        $(ths).css('background','#ccc');
        setTimeout(function() {
            $(ths).css('border','1px solid #CCCCCC');
            $(ths).css('background','#fff');
        }, 500);
    }
    $(function () {
        $('body').on('keypress','.search-input', function(event) {
            var tempval = $(this).val();
            if(event.keyCode == 13 && tempval.trim() != '' && tempval.trim() != undefined) {
                $(this).parent().children('div').each(function() {
                    if($(this).text().trim() == tempval) {
                        tempval = '';
                        showExist(this);
                    }
                });
                if(tempval != '') {
                    $(this).before('<div attr-type="tagstitle" attr-scr="'+tempval+'">'+tempval+'<span class="glyphicon glyphicon-remove"></span></div>');
                    searchData(1);
                }
                $(this).val('');
            }
        }).on('click','.search-div span', function() {
            $(this).parent().remove();
            searchData(1);
        }).on('click','.search-div', function() {
            $('.search-input').focus();
        }).on('click','.categories li a', function() {
            var tempval = $(this).text();
            var id      = $(this).attr('attr-cid');
            if($(".search-div [attr-scr='"+id+"']").length > 0) {
                showExist(".search-div [attr-scr='"+id+"']");
            } else {
                $('.search-div input').before('<div attr-type="category" attr-scr="'+id+'">'+tempval+'<span class="glyphicon glyphicon-remove"></span></div>');
                searchData(1);
            }
        }).on('click','.location li a', function() {
            var tempval = $(this).text();
            if($(".search-div [attr-scr='"+tempval+"']").length > 0) {
                showExist(".search-div [attr-scr='"+tempval+"']");
            } else {
                $('.search-div input').before('<div attr-type="location" attr-scr="'+tempval+'">'+tempval+'<span class="glyphicon glyphicon-remove"></span></div>');
                searchData(1);
            }
        }).on('click','.clicksearch',function() {
            var type = $(this).find('.searchtypeval').text().toLowerCase();
            $('.searchtypeval').text(type);
            $('.searchtype').val(type);
            if(type == 'store'){
                $(this).find('.searchtypeval').text('product');
            } else {
                $(this).find('.searchtypeval').text('store');
            }
            searchData(1);
        }).on('click','.pagination li a',function(event) {
            var loca = $(this).attr('href');
            loca = loca.split('page=');
            searchData(loca[1]);
            event.preventDefault();
        });

        $('.main_wrapper').each(function() {
            $(this).prev().remove();
            $(this).attr('class','');
            $(this).children().attr('class','');
        });
    });
    function searchData(page) {
        var tagstitle = [];
        var category = [];
        var location = [];
        var userid = $('.userid').val();
        $('.search-div [attr-type="tagstitle"]').each(function () {
            tagstitle.push($(this).attr('attr-scr'));
        });
        $('.search-div [attr-type="category"]').each(function () {
            category.push($(this).attr('attr-scr'));
        });
        $('.search-div [attr-type="location"]').each(function () {
            location.push($(this).attr('attr-scr'));
        });
        if (tagstitle.length > 1) {
            tagstitle = tagstitle.join('|');
        }
        if (category.length > 1) {
            category = category.join('|');
        }
        if (location.length > 1) {
            location = location.join('|');
        }
        var searchtype = $('.searchtype').val();
        var param = "tagstitle="+tagstitle+"&category="+category+"&location="+location+"&page="+page+"&searchtype="+searchtype;

        if(Number(userid) > 0 && userid != undefined) {
            param = param+'&type=dashboard';
        }

        $.ajax({
            url     :'/stores/storedashboardfilter',
            type    :'POST',
            dataType:'json',
            data    :param,
            success: function(response) {
                $(".storediv").html(response.html);
            }
        });
    }
    function checkStores() {
        var totalstore   = Number($('.pro_item').length);
        var defaultstore = '{$config.freesubscription.store}';
        $.ajax({
            type    : "POST",
            url     : "/stores/getsubcount",
            data    : 'sid=0&type=store',
            async   : true,
            dataType: "json",
            success : function(data) {
                val   = data.count;
                val   = Number(val) +  Number(defaultstore);
                if(totalstore < val) {
                    location.href="{$config.url}/stores/create";
                } else {
                    $('.div_content').html('Sorry you can able add maximum {$config.freesubscription.store} store for free.</b>\
                    If you want to add more stores, please <a href="{$config.url}/stores/recurringpayment/0">click here</a>');
                    $('#show_category_pay').modal('show');
                }
            }
        });
    }
</script>
