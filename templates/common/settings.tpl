

            <li style="position:relative">
                <button class="dropdown-toggle" type="button" id="menu1" data-toggle="dropdown"><i class="flaticon-settings"></i>Settings
                    <span class="caret"></span></button>
                <ul class="dropdown-menu" role="menu" aria-labelledby="menu1">
                    <li role="presentation"><a role="menuitem" tabindex="-1" href="{$config.url}/profile_settings">Profile</a></li>
                    
                    <!-- ===================== start change by divyesh (changes) ===================== -->
                    {if $loged.business_type != 'dispensary'}
                    <li role="presentation"><a role="menuitem" tabindex="-1" href="{$config.url}/profile_settings/sales_support_settings">Sales Support</a></li>
                    {/if}
                    <!-- ===================== end change by divyesh (changes) ===================== -->
                    
                    <li role="presentation"><a role="menuitem" tabindex="-1" href="{$config.url}/dashboard/messages">Messages</a></li>
                    <li role="presentation"><a role="menuitem" tabindex="-1" href="{$config.url}/dashboard/payments">Accounting</a></li>
                   <!--  <li role="presentation"><a role="menuitem" tabindex="-1" href="{$config.url}/package">Membership</a></li> -->
                    <li role="presentation"><a role="menuitem" tabindex="-1"  href="{$config.url}/dashboard/password">Change Password</a></li>
                    <li role="presentation"><a role="menuitem" tabindex="-1" href="{$config.url}/profile_settings/shipping">Shipping address changes</a></li>
                    <!-- <li role="presentation"><a role="menuitem" tabindex="-1" href="{$config.url}/profil_settings/billing">Billing and Account Information</a></li> -->
                    <li role="presentation"><a role="menuitem" tabindex="-1" href="{$config.url}/dashboard/notification_manager">Notifications</a></li>
                    <li role="presentation"><a role="menuitem" tabindex="-1" href="{$config.url}/dashboard/referrals">Referrals</a></li>
<!--                     <li role="presentation"><a role="menuitem" tabindex="-1" href="{$config.url}/adwords/show_adwords">Advertisement</a></li> -->
                </ul>
            </li>
