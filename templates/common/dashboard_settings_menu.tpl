<ul class="dropdown-menu sidebar-menu links-wrapper dev-links-wrapper">
    <li class="maincat {if $myrequests}active p0 {/if}"><a href="{$config.url}/dashboard/myrequests">Dashboard</a></li>
    <li class="maincat {if $profile_settings}active p0 {/if}"><a href="{$config.url}/profile_settings">Profile</a></li>

    <!-- ===================== start change by divyesh (changes) ===================== -->
    {if $loged.business_type != 'dispensary'}
    <li class="maincat {if $sales_support_settings}active p0 {/if}"><a href="{$config.url}/profile_settings/sales_support_settings">Sales Support</a></li>
    {/if}
    <!-- ===================== end change by divyesh (changes) ===================== -->

    <li class="maincat {if $messages}active p0{/if}"><a href="{$config.url}/dashboard/messages/inbox">Messages</a></li>
    <li class="maincat {if $payments_activity}active p0{/if}"><a href="{$config.url}/dashboard/payments">Accounting</a></li>
    <!-- <li class="maincat {if $membership_details}active p0{/if}"><a href="{$config.url}/package">Membership</a></li> -->
    <li class="maincat {if $password}active p0{/if}"><a href="{$config.url}/dashboard/password">Change Password</a></li>
    <li class="maincat {if $shipping}active p0{/if}"><a href="{$config.url}/profile_settings/shipping">Shipping Address Changes</a></li>
    <li class="maincat {if $notification_manager}active p0{/if}"><a href="{$config.url}/dashboard/notification_manager">Notifications</a></li>
    <li class="maincat {if $referrals}active p0{/if}"><a href="{$config.url}/dashboard/referrals">Referrals</a></li>
    <li class="maincat {if $stax}active p0{/if}"><a href="{$config.url}/profile_settings/stax">Sales Tax</a></li>

    {if $loged.business_type != 'dispensary'}
    <li class="maincat {if $transaction_ratings}active p0 {/if}"><a href="{$config.url}/profile_settings/transaction_ratings">Transaction Ratings</a></li>
    {/if}
    {if $loged.business_type == 'dispensary'}
    <li class="maincat {if $transaction_ratings}active p0 {/if}"><a href="{$config.url}/profile_settings/transaction_ratings">Transaction Ratings</a></li>
    {/if}

    <li class="maincat {if $pending_payments}active p0{/if}"><a href="{$config.url}/profile_settings/pending_payments">Pending Payments</a></li>
</ul>
