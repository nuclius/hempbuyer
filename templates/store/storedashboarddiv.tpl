
<div class="storebox col-md-12" style="">
    <div class="h3 nwftn storeboxh" style="margin-left: 14px;">
        Sponsored Stores
    </div>
    {foreach $stores as $key => $val}
        {if $val.adstore == 1}
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
<div class="storebox col-md-12" style="min-height:230px;">
    <div class="h3 nwftn storeboxh" style="margin-left: 14px;">
        Other Stores
    </div>
    {foreach $stores as $key => $val}
        {if $val.adstore == 0}
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
<div class="col-md-12 text-center">
    {if $stores.length <= 0}No stores are available{/if}
</div>
<div class="col-md-12">
    <div class="pull-right">
        {$pagination_html}
    </div>
</div>
