<a class="nmobile-blayer fs-nav"></a>
<div class="row">
    <div class="col-sm-12 confLinkCol">
      <div class="container mb-10 text-right">

<!--             {$loged.state_abbr}
            {$loged.userid} -->

            {if $loged.business_settings.open_bid == 1}
            <a class="fund-link" href="{$config.url}/product/checkout/cart/">{if $loged.userid > 0} Cart &nbsp;|&nbsp; {/if}</a> {/if}
            <a class="fund-link" href="{$config.url}/dashboard/payments">{if $loged.userid > 0}Accounting &nbsp;|&nbsp; {/if}</a>
            <a class="fund-link" href="{$config.url}/payment/wirefund"> Fund My Herbee Account {if $loged.userid > 0} &nbsp;|&nbsp; {/if}</a>
            <a class="fund-link" href="{$config.url}/dashboard/payments">{if $loged.userid > 0}Account Balance : ${$userbalance.balance}{/if}</a>
            <a class="fs-nav"><i class="fa fa-bars"></i>Navigation</a>
      </div>
        <ul>
                <!-- <li>
                    <a href="{$config.url}/market/selection"><i class="fa fa-home" aria-hidden="true"></i> Welcome Page</a></li> -->

                {if $loged.business_settings.open_bid == 1}
                <li>
                    <a href="{$config.url}/dashboard/myoffers"><i class="fa fa-list" aria-hidden="true"></i>Market Activity Dashboard </a>
                </li>
                {/if}
                {if $loged.business_settings.open_bid == 0}
                <li>
                    <a href="{$config.url}/dashboard/seller/selling"><i class="fa fa-list" aria-hidden="true"></i>Market Activity Dashboard </a>
                </li>
                {/if}
            {if $loged.business_settings.open_bid == 1}
            <li style="position:relative">
                <button class="dropdown-toggle" type="button" id="menu2" data-toggle="dropdown"><i class="flaticon-auction"></i>Open Market<span class="caret"></span></button>
                <ul class="dropdown-menu" role="menu" aria-labelledby="menu2">
                    <li role="presentation"><a role="menuitem" tabindex="-1" href="{$config.url}/openbid/market">Go to Open Market</a></li>
                    <li role="presentation"><a role="menuitem" tabindex="-1" href="{$config.url}/product/openbid/post">Post Item</a></li>
                </ul>
            </li>
            {/if}

                <li><a href="{$config.url}/directbuy"><i class="flaticon-shopping-cart"></i>Direct Market</a></li>

                <!-- <li>  <a href="{$config.url}/directbuy/virtualmall"><i class="flaticon-shopping-cart"></i>Go to Virtual Mall of Stores</a></li> -->

                {if $loged.business_type!='dispensary'}
                    <li>
                    {if $loged.storeid > 0}
                        <a href="{$config.url}/stores/view/{$loged.storeid}"><i class="flaticon-business"></i>My Store</a>
                    {/if}
                    {if $loged.storeid == 0}
                    <a href="{$config.url}/stores/create"><i class="flaticon-business"></i>Create Store</a>
                    {/if}
                    </li>
                {/if}

                {if $ads_page_show == 1}
                    <li>  <a href="{$config.url}/stores/current_campaigns/"><img src="{$config.url}/images/ads.png" alt="">Advertising</a></li>
                {/if}
<!-- {if $loged.business_settings.relationship == 1}
                <li>
                    <a href="{$config.url}/dashboard/relationship/inbox"><i class="fa fa-thumbs-up" aria-hidden="true"></i>Relationships</a>
                </li>
{/if} -->
<!-- {if $loged.business_settings.research == 1}
                <li><a href="{$config.url}/dashboard/market/research"><i class="flaticon-research-work"></i>Research</a></li>
{/if} -->
                    {include file="common/settings.tpl" nocache}

        </ul>
    </div>
</div>
<script type="text/javascript">
    $('.fs-nav').click(function(){
        $('body').toggleClass('sn-open');
    });
</script>
