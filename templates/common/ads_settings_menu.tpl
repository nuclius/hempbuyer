<ul class="drodpdown-menu sidebar-menu links-wrapper dev-links-wrapper">
        {if $alreadyads > 0}
        <li class="maincat p0 {$adsmenu.store}"><a href="{$config.url}/stores/ads">Advertise Your Store</a></li>
        {/if}
        {if $alreadyads <= 0}
         <li class="maincat p0 {$adsmenu.store}"><a href="{$config.url}/stores/ads">Advertise Your Store</a></li>
        {/if}

        <li class="maincat p0 {$adsmenu.product}"><a href="{$config.url}/stores/product/ads">Advertise Your Product</a></li>
        <li class="maincat p0 {$adsmenu.brand}"><a href="{$config.url}/stores/brands/ads">Advertise Your Brand</a></li>
        <li class="maincat p0 {$adsmenu.camp}" ><a href="{$config.url}/stores/current_campaigns/">Current Campaigns</a></li>
</ul>
