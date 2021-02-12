{if $storeProducts.length == 0}
  <div class="text-center">{$phrase.no_products_exist}</div>
{/if}
  <div class="scroll_container scroll_search" style=" top:10px;"><!--Total Scroll Container-->

<div class="main_contents" id="feature__horiz_container_outer">





   <div class="liconts-list" style="margin-top:28px;">





  <div class="strprd_hd"><div class="arr_up" val="1" onclick="show_this('search',this)"></div><div class="p-head" style="color:#666666; font-family:helvetica;">Search Results   </div><div class="gry_but" onclick="view_store()"><span>View Store</span></div><div class="feature-buts">
      <div class="selected  gry_but" onclick="location.reload();"><span>Cancel</span></div>
      <div class="selected  gry_but edit_mode" onclick="onvll();"><span>Stock Selected</span></div>
  </div></div>
<div class="stor_dat">

      <ul class="product_view search_product_view">
{foreach $storeProducts as $key => $val}
    <li class=" {mainclass} product_li class_eq projector_69355106" id="search_product_view_69355106" style="height:auto;">
        <div class="container_img" style="width:130px; height:auto; border:none;">
            <div style="height:135px; position:relative; width:130px; margin-top:0px; vertical-align:middle; cursor:pointer;">
                <div style="position:absolute; bottom:0px;" >
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
                    </div>
                    {if !$val.img1}
                        <img src="{$config['imgpath']}no_img.png" alt="Image" width="135" height="175" class="img-x-69355106" >
                    {else if $val.img1 != '' && $val.img1 != null && $val.img1 != 'null'}
                        <img src="{$config.url}/uploads/product/{$val.img1}" width="135" height="175" class="img-x-69355106" wid="">
                    {/if}
                </div>
                <div class="str-limg" style="position:static;">   <div class="checker_off off s_p_c_69355106 edit_mode" style="left:5px; bottom:9px;"  onclick="on_off_c(this,'{$val.id}')"><input class="edit_mode checker {$val.id}" name="product[]" value="{$val.id}" type="checkbox"></div></div>
            </div>
            <div style="width:130px; height:65px;" >
                <div style="color: #333; font-weight:bolder; margin-top:10px; cursor:pointer; font-size: 12px;height:auto;text-transform: capitalize;overflow: hidden;">{$commonfunction.shorten($val.title,15)}</div>
                <div style="color: #999999; cursor:pointer; font-size: 12px;height:20px;font-weight: 500;text-transform: capitalize;overflow: hidden;">{$commonfunction.shorten($val.description,100)}</div>
            </div>
        </div>
    </li>
<!-- <div class="col-md-4 col-sm-6 col-xs-12 part1 ione8 {if $val.market_status != 'open'} disabled {/if} product_add_{$val.id}">
  <div class="hom3 homem3 " style="min-height: 260px;"> <a href="#x" class="thumbnail imgh"><img src="{if $val.img1 == ''}{$config['imgpath']}no_img.png    {else if $val.img1 != ''}{$config.url}/uploads/product/{$val.img1}{/if}" alt="Image" class="img-responsive ione4"></a>
    <div>

    </div>
    <div class="slid4 ione6 ione7" style="clear: both;min-height: 65px;"><b>{$commonfunction.shorten($val.title,15)}</b></div>
    <div class=" slid3 ione5 ione9">{$commonfunction.shorten($val.description,100)}</div>
    <div class=" slid5 ione9" style="font-size:12px;">
      <div class="col-md-6 col-sm-6 col-xs-6 text-left dfgh padlef0" style="padding-right: 0;"><b>{$val.qty-$val.sold-$val.booked} {$phrase.quantity}{$phrase.no_products_exist}</b></div>
      <div class="col-md-6 col-sm-6 col-xs-6 text-right dfgh padlef0"><b><span class="curr_symbol">{$currency} </span>{$val.bprice}</b></div>
    </div>
  </div>
  <button type="button" onclick="addStore('{$val.id}','{$id}')" class="btn btn-danger  ione9" style="font-size: 12px;">{$phrase.add_to_store}</button>
</div> -->
{/foreach}
   </ul>

      </div>
     </div>



    </div>

    </div>
