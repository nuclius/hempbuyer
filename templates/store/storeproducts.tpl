<div class="scroll_container scroll_search" style="position:relative; top:10px;"><!--Total Scroll Container-->
<div class="main_contents" id="feature__horiz_container_outer">
   <div class="liconts-list" style="margin-top:28px;">
  <div class="strprd_hd"><div class="arr_up" val="1" onclick="show_this('search',this)"></div><div class="p-head" style="color:#666666; font-family:helvetica;">Search Results    </div><div class="gry_but" onclick="window.location='{$config.url}/stores/view/{$store.id}'"><span>View Store</span></div><div class="feature-buts"><div class="uselected gry_but edit_mode" onclick="unselect('x');"><span>Unstock Selected</span></div></div></div>
     <div class="stor_dat">
      <ul class="product_view search_product_view">
      {foreach $storeProducts as $key => $val}
             <li class=" {mainclass} product_li class_eq projector_68812109" id="search_product_view_68812109" style="height:auto;">
                <div class="container_img" style="width:130px; height:auto; border:none;">
                     <div style="height:180px; position:relative; width:130px; margin-top:0px; vertical-align:middle; cursor:pointer;">
                        <div style="position:absolute; bottom:0px;">
                        <img src="{$config.url}/uploads/product/{$val.img1}" class="img-x-68812109" width="130" height="175"  wid="">
                        </div>
                         <div class="str-limg" style="position:static;">   <div class="checker_off off s_p_c_68812109 edit_mode" style="left:5px; bottom:9px;"><input class="edit_mode checker p_c_68812109" name="product[]" value="68812109" type="checkbox"></div></div>
                    </div>
                    <div style="width:130px; height:65px;" >
                    <div style="color: #333; font-weight:bolder; margin-top:10px; cursor:pointer; font-size: 12px;height:auto;text-transform: capitalize;overflow: hidden;">{$commonfunction.shorten($val.title,15)}</div>
                    <div style="color: #999999; cursor:pointer; font-size: 12px;height:20px;font-weight: 500;text-transform: capitalize;overflow: hidden;">{$commonfunction.shorten($val.description,15)}</div>
                    </div>
                </div>
             </li>
             {/foreach}

      </ul>
     </div>
    </div>
    </div>
   </div>

 <style type="text/css">

   .main_contents {
    clear: both;
    margin: 0 auto;
    overflow: hidden;
    width: 1024px;
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

.feature-buts {
    float: right;
    height: 43px;
    margin-right: -1px;
    overflow: hidden;
}
.strprd_hd .gry_but {
    float: left;
    margin: 4px;
}
.edit_mode {
    display: none;
}
.uselected {
    float: left;
    height: 41px;
    margin-left: 2px !important;
    margin-right: 0 !important;
    width: auto !important;
}
.stor_dat {
    border-bottom: 1px solid rgb(189, 184, 184);
}
.stor_dat ul.product_view {
    display: inline-table;
    list-style: outside none none;
    margin: 0;
    padding: 0;
    position: relative;
    width: 1036px;
}
.liconts-list .stor_dat ul.product_view li.product_li {
    float: left;
    margin: 10px 8px;
    padding: 0;
    width: 130px;
}
.container_img div {
    overflow: hidden;
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
</style>
