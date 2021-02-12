<div class="col-md-3 sidebar  mb-25">
    <ul class="sidebar-menu links-wrapper">
        <li class="maincat p0 {if $wirefund == 1} active {/if}"><a  href="{$config.url}/payment/wirefund">Wire funds to Herbee</a></li>
        <li class="maincat p0 {if $sendcheck == 1} active {/if}"><a  href="{$config.url}/payment/sendcheck">Send a check to Herbee</a></li>
        <li class="maincat p0 {if $gateway == 1} active {/if}"><a  href="{$config.url}/payment/gateway">Pay through our payment gateway</a></li>
        <li class="maincat p0 {if $fundRequest == 1} active {/if}"><a  href="{$config.url}/payment/refundrequest">Send Fund Request</a></li>
    </ul>
</div>