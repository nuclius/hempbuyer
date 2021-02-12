

<ul class="nav nav-pills super-sub-link">
    <li {if $myrequests == 1} class="active"{/if}><a href="{$config.url}/dashboard/myrequests">Open Tasks</a></li>
    <li {if $mycorders == 1} class="active"{/if}><a href="{$config.url}/dashboard/mycorders"> Orders to Confirm</a></li>
    <li {if $mypurchase == 1} class="active"{/if}><a  href="{$config.url}/dashboard/mypurchase">Confirmed Purchases</a></li>
    <li {if $mysale == 1} class="active"{/if}><a  href="{$config.url}/dashboard/mysale">Confirmed Sales</a></li>
    <li {if $myrpurchase == 1} class="active"{/if}><a  href="{$config.url}/dashboard/myrpurchase">Rejected Purchase Offers</a></li>
    <li {if $myrsale == 1} class="active"{/if}><a  href="{$config.url}/dashboard/myrsale">Rejected Sales Offers</a></li>    
    <li {if $myoffers == 1} class="active"{/if}><a  href="{$config.url}/dashboard/myoffers">My Offers</a></li>    
    <li {if $openbid_inventory == 1} class="active"{/if}><a  href="{$config.url}/dashboard/openbid_inventory">Inventory</a></li>
</ul>