
<style>
.kjb1z {
    height: 75px;
    overflow: hidden;
    margin-bottom: 10px;
    text-align: justify;
}
</style>

{foreach $storeFProducts as $key => $val}


{if ($val.market_status != 'removed' && $loged.userid == $val.user_id) || ($loged.userid != $val.user_id && $val.market_status == 'open')}
<div class="col-md-12" attr-product-id="{$val.id}" attr-pcid="{$val.parent_category_id}">
    {if $val.market_status != 'open'}
    <div class="pro_item pointer_cur clearfix " title="View Product" style="cursor:not-allowed;">
    {/if}
    {if $val.market_status == 'open'}
    <div class="pro_item pointer_cur clearfix " title="View Product"  onclick="location.href='{$config.url}/product/view/{$val.id}/{$store.id}';">
    {/if}
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
        </div>
        <div class="block1_img">
            {if !$val.img1}
                <img src="{$config.url}/images/stores/no-imgst.png" alt="Image" class="img-responsive ">
            {else if $val.img1 != '' && $val.img1 != null && $val.img1 != 'null'}
                <img src="{$config.url}/uploads/product/{$val.img1}"  alt="Image" class="img-responsive">
            {/if}
        </div>
        <div class="clearfix"></div>
        <div class="col-md-12">
            <div class="pro_head">{$commonfunction.shorten($val.title,15)} </div>
            <div class="pro-des">{$commonfunction.shorten($val.description,30)} </div>
        </div>
    </div>
</div>
{/if}
                      {/foreach}
