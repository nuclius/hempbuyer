<div class="db-gray-box">
    <div class="container">
        <ol class="breadcrumb">
            <li><a href="/">Home</a></li>
            <li><i class="fa fa-angle-right"></i></li>
            {if $page_name != 'set_shipping_address' && $page_name != 'bank_list' && $page_name != 'bank_details' &&  $page_name != 'escrow_details'}
                <li class="show-seller-dashboard-active active">Seller Dashboard</li>
                <li class="show-buyer-dashboard-active active">Buyer Dashboard</li>
                <li class="show-profile-active active">Profile Info</li>
                <li class="show-message-active active">Inbox</li>
                <li class="show-advertisement-active active">Buyer Dashboard</li>
                <li class="show-classified-active active">Classifieds</li>
            {/if}
            {if $page_name == 'set_shipping_address'}
                <li class="active">Shipping Address</li>
            {/if}
            {if $page_name == 'bank_list'}
                <li class="active">Bank List</li>
            {/if}
            {if $page_name == 'bank_details'}
                <li class="active">Bank Details</li>
            {/if}
            {if $page_name == 'escrow_details'}
                <li class="active">Escrow Details</li>
            {/if}
        </ol>
        <ul class="list-inline user-menu">
            <li class="list-inline-item">
                <a href="/seller/openAuction">AUCTION</a>
            </li>
            <li class="list-inline-item">
                <a href="/profileInfo">PROFILE</a>
            </li>
            <li class="list-inline-item">
                <a class="un-ico" href="/inbox/all">INBOX 
                    <b class="un-icob">0</b>
                </a>
            </li>
            <li class="list-inline-item">
                <a class="show-advertisement-active1" href="/advertisements">
                    ADVERTISEMENT
                </a>
            </li>
            <li class="list-inline-item pp-list">
                <a class="btn btn-pp show-seller-dashboard-active post_your_product" href="/product">
                    POST YOUR PRODUCT
                </a>
            </li>
        </ul>
    </div>
</div>

<script>
    $('html, body').css({
        overflow: 'hidden',
        height: '100%'
    });
    $(window).on('load', function() {
        $('html, body').css({
            overflow: 'auto',
            height: 'auto'
        });
        //$('.loader').fadeOut();
    });
</script>