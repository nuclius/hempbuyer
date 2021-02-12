<footer>
    <div class="footContainer">
        <div class="row">
        <div class="col-12">
        <div class="footer-logo">
                    <img src="{$config.url}/images/footLogo.png" />
                </div>
        </div>
            <div class="footLink col-6 col-md-3 col-lg-3">
                <h5 class="fhead">Make money with us</h5>
                <ul class='apply-active'>
                    <li><a  href='/how_it_works#buyersJoinInfo' class="">Buyers join us</a></li>
                    <li><a  href='/how_it_works#SellersJoinInfo' class="">Seller join us</a></li>
                    <li><a  href='{$config.url}/banners' class="">Affiliates/Referrals</a></li>
                    <li><a  href='/how_it_works#bizDevelopment' class="">Business development/Consulting</a></li>
                    <li><a  href='/how_it_works#payment' class="">How it works - payments</a></li>
                    <li><a  href='/feeSchedule' class="">Payments/Fee schedule</a></li>
                </ul>
            </div>
            <div class="footLink col-6 col-md-3 col-lg-3">
                <h5 class="fhead">Get your word out</h5>
                <ul class='apply-active'>
                    <li><a  href='/how_it_works#startSelling' class="">Start selling today</a></li>
                    <li><a  href='/how_it_works#AuctionMarket' class="">Auction & market</a></li>
                    <li><a  href='/classified' class="">Classifieds</a></li>
                    <li><a  href='/advertisements' class="">Advertise with us</a></li>
                    <li><a  href='/affiliate_terms' class="">Affiliate terms</a></li>
                </ul>
            </div>
            <div class="footLink col-6 col-md-3 col-lg-3">
                <h5 class="fhead">More stuff</h5>
                <ul class='apply-active'>
                    <li><a  href='/how_it_works' class="">How it works</a></li>
                    <li><a  href='/aboutUs' class="">Our story</a></li>
                    <li><a  href='/how_it_works#faq' class="">FAQ</a></li>
                    <li><a  href='/values_ethics' class="">Values, ethics & conduct</a></li>
                    <li><a  href="https://hempbuyer.com/blog/" target="_blank" class="">Blog</a></li>
                    <li><a  href='/comingsoon' class="">Tutorials</a></li>
                </ul>
            </div>
            <div class="footLink col-6 col-md-3 col-lg-3">
                <h5 class="fhead">Stay in touch</h5>
                <ul class='apply-active'>
                    <ul class="social-wrap">
                    <li>
                        <a href="https://www.facebook.com/Hempbuyer" target="_blank">
                            <i class="fab fa-facebook-f"></i>
                        </a>
                    </li>
                    <li>
                        <a href="https://www.instagram.com/hempbuyer/" target="_blank"
                           <i class="fab fa-instagram" style="font-weight: 700;font-size: 16px;"></i>
                        </a>
                    </li>
                    <li>
                        <a href="https://www.linkedin.com/in/angellaconrard" target="_blank">
                            <i class="fab fa-linkedin-in"></i>
                        </a>
                    </li>
                    <li>
                        <a href="https://twitter.com/BuyerHemp" target="_blank">
                            <i class="fab fa-twitter"></i>
                        </a>
                    </li>
                </ul>
                <ul class='apply-active footContact' style="text-transform: none;">
                    <li><a href='tel:1-800-420-4196' style="text-transform: none;" class=''><i class="fas fa-phone-alt"></i>1-800-420-4196</a></li>
                    <li><a href='/contactUs' style="text-transform: none;" class=''><i class="fas fa-envelope"></i>Email Us</a></li>
                </ul>
            </div>
        </div>

        <div class="row mt-4">
            <div class="col-12">
                <ul class='apply-active footReg'>
                    <li><h3>Join like minded hemp professionals that want to do business with you.</h3></li>
                    <li>
                        {if $loged.userid}
                        <a class="btn btn-prev" href="/">Register</i></a>
                        {/if}
                        {if !$loged.userid}
                        <a class="btn btn-prev" href="/signup">Register</i></a>
                        {/if}
                    </li>
                </ul>
            </div>
        </div>

        <div class="row mt-4 footStatement">
            <div class="col-12 col-sm-12 col-md-12 col-lg-12 text-center">
                <h4>ETHICS STATEMENT</h4>
            </div>
            <div class="col-12 col-sm-12 col-md-12 col-lg-12">
                <h5>Hempbuyer serves the hemp industries worldwide through those who share our mission of honesty, professionalism, integrity, character and compassion.</h5>
            </div>
            {* <div class="col-12 col-lg-4">
                <div class="footer-logo">
                    <img src="{$config.url}/images/footer-logo.png" />
                </div>
            </div>
            <div class="col-6 col-sm-4 col-md-3 col-lg-2">
                <h5 class="fhead">ABOUT</h5>
                <ul class='apply-active'>
                    <li><a href='/aboutUs' class="">About Us</a></li>
                    <li><a href='/contactUs' class="">Contact Us</a></li>
                    <li><a href='/#HowItWorks' class="">How It Works</a></li>
                    <li><a href='/#' class="">Membership</a></li>
                    <li><a href='/market' class="">Auction & Market</a></li>
                    <li><a href='/banners' class="">Referral Banners</a></li>
                </ul>
            </div>
            <div class="col-6 col-sm-4 col-md-3 col-lg-2">
                <h5 class="fhead">HELP</h5>
                <ul class='apply-active'>
                    <li><a href='/comingsoon' class="">Terms & Conditions</a></li>
                    <li><a href='/comingsoon' class="">Privacy Policy</a></li>
                    <li><a href='/advertisements' class="">Advertise with Us</a></li>
                </ul>
            </div>
            <div class="col-6 col-sm-4 col-md-3 col-lg-2">
                <h5 class="fhead">CONTACT NUMBER</h5>
                <ul class='apply-active'>
                    <li><a href='/contactUs' class=''>800-420-4196</a></li>
                </ul>
            </div>
            <div class="col-6 col-sm-4 col-md-3 col-lg-2">
                <h5>FOLLOW US VIA</h5>
                <ul class="social-wrap">
                    <li>
                        <a href="/#" target="_blank">
                            <i class="fab fa-facebook-f"></i>
                        </a>
                    </li>
                    <li>
                        <a href="/#" target="_blank">
                            <i class="fab fa-instagram"></i>
                        </a>
                    </li>
                    <li>
                        <a href="/#" target="_blank">
                            <i class="fab fa-linkedin-in"></i>
                        </a>
                    </li>
                    <li>
                        <a href="/#" target="_blank">
                            <i class="fab fa-tumblr"></i>
                        </a>
                    </li>
                </ul>
            </div> *}
            <p>1 Lucky Dog LLC dba Hemp Buyer is a Delaware Limited Liability Corporation. Disclaimer: Industrial Hemp and finished products on this website is produced and distributed in compliance with the Federal Farm Bill of 2018. It may be legally possessed and distributed according to Federal guidelines. Hemp Disclaimer: The statements made regarding these products have not been evaluated by the Food and Drug Administration. The efficacy of these products has not been confirmed by FDA-approved research. These products are not intended to diagnose, treat, cure or prevent any disease. All information presented here is not meant as a substitute for or alternative to information from health care practitioners. Please consult your health care professional about potential interactions or other possible complications before using any product. The Federal Food, Drug and Cosmetic Act requires this notice.</p>
        </div>
    </div>
    
    <div class="copy-right">
        <a href='/terms_of_use' style="color: rgba(255, 255, 255, .5);">Terms and Conditions</a>
        Copyright © {$current_year} Lucky Dog, LLC
        <a href='/privacy_policy' style="color: rgba(255, 255, 255, .5);">Privacy Statement</a>
    </div>
</footer>


<script>
       $(document).ready(function (e) {
           console.log('called1')
            $(document).keypress(function (e) {
                if (e.which == 13) {
                    console.log('called')
                    if ($("#watchlist-modal").css("display") == "block") {
                        $("#watchlist-modal").modal('hide')
                        window.location.reload();
                    }
                }
            });
        });
    
</script>

<!-- Watchlist Popup - Starts -->
<div class="modal fade hb-modal" id="watchlist-modal" data-backdrop="static" data-keyboard="false">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <img src="{$config.url}/images/logo.png" class="m-auto" /> 
                <button type="button" class="close watchlist-redirect" data-dismiss="modal" aria-hidden="true">
                    <i class="fa fa-times-circle"></i>
                </button>
            </div>
            <div class="modal-body"> 
                <h4 class="text-center" style="text-transform: uppercase;"></h4> 
                <div class="lsc-msg" id="watchlist_popup_text">
                    {* <img src="/images/user-icon.png" alt="user"> *}
                </div>
                <div class="ss-txt watchlist-content">
                </div>
                <button class="btn btn-prev watchlist-redirect">
                    THANK YOU
                </button>
            </div> 
        </div>
    </div>
</div>
<!-- Watchlist Popup - Ends -->

<!-- View Message Popup - Starts -->
<div class="modal fade hb-modal" id="viewMessage" data-backdrop="static" data-keyboard="false">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                 <img src="{$config.url}/images/logo.png" class="m-auto" />
                
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true" id="close_send_inbox">
                    <i class="fa fa-times-circle"></i>
                </button>
            </div>
            <div class="modal-body">
                <h4 class="text-center">Messages</h4> 
            </div>
            <div class="modal-footer" style="display: none;">
                <!-- <textarea id="reply" placeholder="Reply"></textarea>
                <button type="button" id="saveReplyMessage">
                    Reply
                </button> -->
                <form method="post" id="message_reply_form" data-parsley-validate novalidate>
                    <input type="hidden" name="product_id" id="product_id" value="">
                    <input type="hidden" name="from_id" id="from_id" value="">
                    <input type="hidden" name="subject" id="subject" value="">
                    <input type="hidden" name="r_id" id="r_id" value="">
                    <div class="row">
                        <div class="col-sm-12">
                            <textarea class="form-control" id="message" name="message" required></textarea>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-12 mt-2">
                            <button class="btn btn-primary float-right">Send</button>
                            &nbsp; &nbsp;
                             <button class="btn btn-secondary float-right cancel_btn" onclick="$('#close_send_inbox').trigger('click')">Cancel</button>
                            
                        </div>
                    </div>
                    <div class="row" style="margin: 20px -14px 0px;">
                        <div class="col-sm-12" style="text-align: justify;">
                            {if $loged.role == 1}
                                <i style="color: red;"><b>Note: </b>If you are a buyer do NOT include your contact info or ask for the seller’s contact info. We scan and analyze messages to identify potential fraud and policy violations.  Failure to follow policies may trigger the termination of your membership to HempBuyerAuction.</i>
                            {else/}
                                <i style="color: red;"><b>Note: </b>If you are a seller do NOT include your contact info or ask for the buyer’s contact info. We scan and analyze messages to identify potential fraud and policy violations.  Failure to follow policies may trigger the termination of your membership to HempBuyerAuction.</i>
                            {/if}
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<!-- View Message Popup - Ends -->

<!-- Referral Popup - Starts -->
<div class="modal fade hb-modal" id="referralModal" data-backdrop="static" data-keyboard="false">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
            <h4>Affiliates/Referrals</h4>           
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true" id="close_send_inbox">
                    <i class="fa fa-times-circle"></i>
                </button>
            </div>
            <div class="modal-body">
                <div class="media-body" id="affiliates">
                        <p>Shout it from the rooftops! We want to help you make money! When you refer Buyers, you’ll
                            receive a cash percentage of each sale for the first year of their membership. If you
                            publish articles, a blog, or own a website, you get paid. Join our affiliate program and
                            make money when buyers become members and transact. <a
                                href="https://hempbuyerauction.com/banners" > Click here to learn more
                                about it.</a> </p>
                    </div> 
            </div>
            
        </div>
    </div>
</div>
<!-- Referral Popup - Ends -->


    <!-- Fee Modal -->
    <div class="modal fade hb-modal" id="feeModal" data-backdrop="static" data-keyboard="false" tabindex="-1"
        aria-labelledby="feeModalLabel" aria-hidden="true">
        <div style="padding: 0" class="static-cont modal-dialog modal-dialog-centered modal-lg modal-dialog-scrollable">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="feeModalLabel">How It Works - Payments/Fee Schedule</h5>
                    <button type="button" href="#" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="media-body">
                        <table class="table mt-4">
                            <thead class="thead-light">
                                <tr>
                                    <th scope="col">Transaction Value</th>
                                    <th scope="col">Service Fee</th>
                                    <th scope="col">Year 2</th>
                                    <th scope="col">Year 3</th>
                                    <th scope="col">Payment Methods</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>$0-2500</td>
                                    <td>10%</td>
                                    <td>9%</td>
                                    <td>8%</td>
                                    <td>ACH, Credit Card</td>
                                </tr>
                                <tr>
                                    <td>$2501-6250</td>
                                    <td>8%</td>
                                    <td>7%</td>
                                    <td>6%</td>
                                    <td>ACH, Wire</td>
                                </tr>
                                <tr>
                                    <td>$6251-15,000</td>
                                    <td>6%</td>
                                    <td>5%</td>
                                    <td>4%</td>
                                    <td>ACH, Wire</td>
                                </tr>
                                <tr>
                                    <td>$15,001+</td>
                                    <td>4.50%</td>
                                    <td>3.50%</td>
                                    <td>2.50%</td>
                                    <td>Escrow Mandatory</td>
                                </tr>
                            </tbody>
                        </table>
                        <p class="hbaImp text-center">**Minimum service fee is $25</p>
                        <p class="hbaImp text-center">Service Fees Year 4+, Seller’s may opt to continue to conduct
                            transactions over the HBA site.</p>
                        <h3 class="text-center">Transactions $1 - $2500.00 (minimum service fee is $25)</h3>
                        <p>Buyer wins an auction, purchases a buy now listing or makes an offer that is accepted by the
                            seller. The seller is notified he/she has a sale. The buyer populates the shipping address.
                            The seller populates the shipping fees. The buyer pays for the product & shipping via the
                            buyer portal. The seller packages the product and provides tracking of shipment. Funds are
                            released to the seller minus the HBA service fee. Product ships. Transaction completed.</p>

                        <h3 class="text-center">For transactions $2501.00 - $15,000.00</h3>
                        <p>Buyer wins an auction, purchases a buy now listing or makes an offer that is accepted by the
                            seller. The seller is notified he/she has a sale. Transaction coordinator contacts both
                            seller and buyer and schedules an introductory meeting to finalize negotiations and SOP’s
                            via a recorded call or video conferencing. Each transaction is different. Generally samples
                            are purchased and shipped. Buyer and seller agree on inspections, quarantine, testing,
                            transport and insurance coverage. The contract is agreed upon. The contract is executed as
                            agreed. Funds are released to the seller upon completion of the contract. </p>

                        <h3 class="text-center">For transactions > $15,001.00</h3>
                        <p>HBA requires escrow services be used for the safety of both seller and buyer. Escrow services
                            are generally 1% of the sale. It’s very affordable service and well worth the safety it
                            provides. Click Here to learn more about how Escrow works. Sellers must keep in mind 1%
                            escrow services fee and HBA service fees when establishing their product prices. Escrow
                            services fee may be paid by seller, buyer or split between seller and buyer. Terms are
                            negotiable as part of the sale contract.</p>
                        <p>Buyer wins an auction, purchases a buy now listing or makes an offer that is accepted by the
                            seller. The seller is notified he/she has a sale. Transaction coordinator contacts both
                            seller and buyer and schedules an introductory meeting to finalize negotiations and SOP’s
                            via a recorded call or video conferencing. Each transaction is different. Generally samples
                            are purchased and shipped. Buyer and seller agree on inspections, quarantine, testing,
                            transport and insurance coverage. The contract is agreed upon. Buyer funds the escrow
                            account. The contract is executed as agreed. Funds are released to the seller upon
                            completion of the contract. </p>

                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Fee Modal End -->

    <!-- Escrow Modal -->
    <div class="modal fade hb-modal" id="escrowModal" data-backdrop="static" data-keyboard="false" tabindex="-1"
        aria-labelledby="escrowLabel" aria-hidden="true">
        <div style="padding: 0" class="static-cont modal-dialog modal-dialog-centered modal-lg modal-dialog-scrollable">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="escrowModalLabel">Escrow - How it works </h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="media-body" id='escrow'>
                        <p>Escrow is a financial instrument held by an independent third party on behalf of the two
                            other parties who are completing a transaction. It’s like a trust account held by a third
                            party while all the seller and buyer’s obligations are fulfilled. All the details of the
                            contract are completed and fulfilled, then funds are released to the seller. </p>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Escrow Modal End -->

    


<!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script> -->
<!-- <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script> -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
<!-- Owl carosal -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/owl.carousel.min.js"></script>
<script src="{$config.url}/socket.io/socket.io.js"></script>
<script src="{$config.url}/js/jquery.flexslider.js"></script>
<script src="{$config.url}/js/jquery.countdown.js"></script>
<script src="{$config['externaljs']}sweetalert.min.js"></script>

<!-- js end -->
<script type="text/javascript">
    var base_url = '{$config.url}';
    var socket = io.connect();
    var servertime = new Date();
    /* socket.on('kva_server_time', function (omg) {
        servertime = new Date(omg);
        return false;
    }); */
    socket.on('sliservertime', function(msg){
        servertime  = new Date(msg.dTime);
        return false;
    });
    $(window).on('beforeunload', function () {
        socket.close();
    });

    var logic = function (currentDateTime) {
        if (currentDateTime.getDate() == servertime.getDate()) {
            this.setOptions({
                minTime: addZero(servertime.getHours()) + ':' + addZero(servertime.getMinutes())
            });
        } else
            this.setOptions({
                minTime: '00:00'
            });
    };
    function addZero(i) {
        if (i < 10) {
            i = "0" + i;
        }
        return i;
    }

    $(document).ready(function () {
        $(".info-wrap").tooltip();
        $(document).on('click', 'img[alt="calendar"]', function(){
            $(this).closest('div').find('input').focus();
        })

        $('.owl-auctions').owlCarousel({
            loop: false,
            rewind: true,
            margin: 20,
            dot: false,
            nav: true,
            autoWidth: true,
            autoplay: true,
            autoplayTimeout: 3000,
            autoplayHoverPause: true,
            responsive: {
                0: {
                    items: 1
                },
                500: {
                    items: 2
                },
                800: {
                    items: 4
                },
                1000: {
                    items: 4
                }
            }
        });

        $.ajax({
            type : 'POST',
            url  : '/getUserUnreadMessageCount',
            data : { },
            dataType : 'json',
            success  : function(data) {
                if(data.status == 'success') {
                    $('.un-icob').html(data.totalInboxUnreadMessageCount);
                    //alert(data.totalInboxUnreadMessageCount);
                }/* else if(data.status == 'failed') {
                    //alert(data.totalInboxUnreadMessageCount);
                } else if(data.status == 'session_expired') {
                    window.location.href = '/signin';
                }*/
            }
        });
    });

    $(window).scroll(function () {
        if ($(window).scrollTop() + $(window).height() > ($(document).height() + 300)) {
            //you are at bottom
            $("body").addClass("viewport-top");
        } else {
            $("body").removeClass("viewport-top");
        }
    });

    $(window).on('load', function() {
        /**
         *  Apply Active Class from Current Page
         */
        var currentPath = window.location.pathname;
        var currentPathHash = window.location.hash;
        $('.apply-active li a').removeClass('active');
        $('.apply-active li a[href="'+currentPath+'"]').addClass('active');

        $('.apply-active li a[href="/'+currentPathHash+'"]').addClass('active');

        var sellerAuctionMenu = ['/seller/openAuction', '/seller/soldAuction', '/seller/draftAuction', '/seller/closedAuction'];
        var buyerAuctionMenu = ['/buyer/activeAuction', '/buyer/wonAuction', '/buyer/lostAuction', '/buyer/buyAuction', '/buyer/watchlist'];
        var profileMenu = ['/profileInfo', '/paymentInfo', '/passwordInfo', '/transactionsInfo'];
        var messageMenu = ['/inbox/all', '/inbox/sent', '/inbox/archive', '/inbox/trash'];
        var advertisementMenu = ['/advertisements', '/advertisement'];
        var classifiedMenu = ['/classified/add'];
        $('.user-menu li a').removeClass('active');
        console.log('currentPath', currentPath);
        if( sellerAuctionMenu.indexOf(currentPath) > -1 || buyerAuctionMenu.indexOf(currentPath) > -1 )
            $('ul.user-menu li:nth-child(1)').find('a').addClass('active');
        else if( profileMenu.indexOf(currentPath) > -1 )
            $('ul.user-menu li:nth-child(2)').find('a').addClass('active');
        else if( messageMenu.indexOf(currentPath) > -1 )
            $('ul.user-menu li:nth-child(3)').find('a').addClass('active');
        else
            $('.user-menu li a[href="'+window.location.pathname+'"]').addClass('active');
        
        if( sellerAuctionMenu.indexOf(currentPath) > -1 ) {
            $('.show-seller-dashboard-active').show();
            $('.show-buyer-dashboard-active, .show-profile-active, .show-message-active, .show-advertisement-active, .show-classified-active').hide();
            $('.apply-active li a[href="/seller/openAuction"]').addClass('active');
        }

        if( buyerAuctionMenu.indexOf(currentPath) > -1 ) {
            $('.show-seller-dashboard-active, .show-profile-active, .show-message-active, .show-advertisement-active, .show-classified-active').hide();
            $('.show-buyer-dashboard-active').show();
            $('.show-advertisement-active1').show();
            $('.apply-active li a[href="/buyer/activeAuction"]').addClass('active');
        }

        if( profileMenu.indexOf(currentPath) > -1 ) {
            $('.show-seller-dashboard-active, .show-buyer-dashboard-active, .show-message-active, .show-advertisement-active, .show-classified-active').hide();
            //$('.show-buyer-dashboard-active').hide();
            $('.show-profile-active').show();
            $('.apply-active li a[href="/profileInfo"]').addClass('active');
        }

        if( currentPath.indexOf('/product') > -1 ) {
            $('.show-seller-dashboard-active').show();
            $('.show-buyer-dashboard-active, .show-profile-active, .show-message-active, .show-advertisement-active, .show-classified-active').hide();
        }

        if( messageMenu.indexOf(currentPath) > -1 ) {
            $('.show-message-active').show();
            $('.show-buyer-dashboard-active, .show-seller-dashboard-active, .show-profile-active, .show-advertisement-active').hide();
        }
        
        if( advertisementMenu.indexOf(currentPath) > -1 ) {
            $('.show-buyer-dashboard-active, .show-seller-dashboard-active, .show-profile-active, .show-message-active').hide();
            $('.show-advertisement-active').show();
        }
        if( classifiedMenu.indexOf(currentPath) > -1 ) {
            $('.show-buyer-dashboard-active, .show-seller-dashboard-active, .show-profile-active, .show-message-active, .show-advertisement-active').hide();
            $('.show-classified-active, .post_your_product').show();
        }

        /*setImmediate(function() {
            $('.loader').fadeOut();
        });*/
        /*setTimeout(function() {
            $('.loader').fadeOut();
        }, 50);*/
    });

    $(document).on('click', '.addToWatchlist', function() {
        var productId = $(this).attr('data-product_id');
        if(productId != '' && productId != 0) {
            var status = $(this).attr('data-status');
            $.ajax({
                type : 'POST',
                url  : '/addToWatchlist',
                data : { productId : productId, status : status },
                dataType : 'json',
                success  : function(data) {
                    /*if(data.status == 'success') {
                        $('#watchlist-modal .modal-title').html(data.statusText);
                        $('#watchlist-modal').modal('show');
                        setTimeout(function() {
                            window.location.reload();
                        }, 1000);
                    } else if(data.status == 'session_expired') {
                        window.location.href = '/signin';
                    } else {
                        $('#watchlist-modal .modal-title').html(data.statusText);
                        $('#watchlist-modal').modal('show');
                    }*/
                    if(data.status == 'session_expired')
                        window.location.href = '/signin';
                    else {
                        $('#watchlist-modal .modal-title').html(data.statusText);
                        $('#watchlist-modal').modal('show'); 
                    }
                    if(status == 'active') {
                        $("#watchlist_popup_text").html("Successfully added to watchlist");
                    } else {
                        $("#watchlist_popup_text").html("Removed from watchlist");
                    }
                }
            });
        } else {
            alert('Product id not found');
            return false;
        }
    });

    $(document).on('click', '#watchlist-modal .watchlist-redirect', function() {
        window.location.reload();
    });

    $(document).on('click', '.viewMessage', function(e) {
        e.preventDefault();
        var messageId = $(this).attr('data-message_id');
        var productId = $(this).attr('data-product_id');
        var rId = $(this).attr('data-r_id');
        var type = $(this).attr('data-type');
        $('#viewMessage .modal-footer #message_reply_form #product_id').val(productId);
        $('#viewMessage .modal-footer #message_reply_form #r_id').val(rId);
        $('#viewMessage .modal-footer').css('display', 'none');
        if(rId != "" && messageId != "" && rId != "0" && messageId != "0") {
            var html = '';
            $.ajax({
                type : 'POST',
                url  : '/inbox/viewMessage',
                data : { messageId : messageId, productId : productId, rId : rId, type : type },
                dataType : 'json',
                success  : function(data) {
                    if(data.status == 'success') {
                        if(data.data.length > 0) {
                            html = '';
                            $.each(data.data, function(i, v) {
                                if(i == 0) {
                                    $('#viewMessage .modal-footer #message_reply_form #subject').val(v.subject);
                                    html += '<p><b>'+v.subject+'</b></p>';
                                }
                                var className = "text-left pull-left";
                                if(data.sessionId == v.from_id)
                                    className = "text-right pull-right";

                                html += '<div class="'+className+'">';
                                html += '<p>'+v.message+'</p>';
                                html += '<span class="'+className+'">'+v.date_add+'</span>';
                                html += '<br><br>';
                                html += '</div>';
                            });
                        }
                        $('#viewMessage .modal-body').html(html);
                        if(type == 'inbox')
                            $('#viewMessage .modal-footer').css('display', 'block');
                        $('#viewMessage').modal('show');
                    } else if(data.status == 'failed') {
                        $('#viewMessage .modal-body').html('No Messages Found');
                        $('#viewMessage').modal('show');
                    } else if(data.status == 'session_expired') {
                        window.location.href = '/signin';
                    }
                    getUserUnreadMessageCount();
                }
            });
        } else {
            alert('Message id not found');
            return false;
        }
    });

    $(document).on('click', '.viewInboxMessage', function(e) {
        e.preventDefault();
        var messageId = $(this).attr('data-message_id');
        var productId = $(this).attr('data-product_id');
        var rId = $(this).attr('data-r_id');
        var type = $(this).attr('data-type');
        var fromId = $(this).attr('data-from_id');
        $('#viewMessage .modal-footer').css('display', 'none');
        $('#viewMessage .modal-footer #message_reply_form #product_id').val(productId);
        $('#viewMessage .modal-footer #message_reply_form #r_id').val(rId);
        $('#viewMessage .modal-footer #message_reply_form #from_id').val(fromId);
        if(rId != "" && messageId != "" && rId != "0" && messageId != "0") {
            var html = '';
            $.ajax({
                type : 'POST',
                url  : '/inbox/updateAndViewMessage',
                data : { messageId : messageId, productId : productId, rId : rId, type : type },
                dataType : 'json',
                success  : function(data) {
                    if(data.status == 'success') {
                        if(data.data.length > 0) {
                            html = '';
                            $.each(data.data, function(i, v) {
                                if(i == 0) {
                                    $('#viewMessage .modal-footer #message_reply_form #subject').val(v.subject);
                                    html += '<p><b>'+v.subject+'</b></p>';
                                }
                                var className = "text-left pull-left";
                                if(data.sessionId == v.from_id)
                                    className = "text-right pull-right";

                                html += '<div class="'+className+'">';
                                html += '<p>'+v.message+'</p>';
                                html += '<span class="'+className+'">'+v.date_add+'</span>';
                                html += '<br><br>';
                                html += '</div>';
                            });
                        }
                        $('#viewMessage .modal-body').html(html);
                        if(type == 'inbox')
                            $('#viewMessage .modal-footer').css('display', 'block');
                        $('#viewMessage').modal('show');
                    } else if(data.status == 'failed') {
                        $('#viewMessage .modal-body').html('No Messages Found');
                        $('#viewMessage').modal('show');
                    } else if(data.status == 'session_expired') {
                        window.location.href = '/signin';
                    }
                    getUserUnreadMessageCount();
                }
            });
        } else {
            alert('Message id not found');
            return false;
        }
    });

    $(document).on('submit', '#message_reply_form', function(e) {
        e.preventDefault();
        if ($('#message_reply_form').parsley().validate()) {
            var formArr = $(this).serializeArray();
            var obj = {};
            if (formArr.length) {
                for (var index = 0; index < formArr.length; index++) {
                    const element = formArr[index];
                    obj[formArr[index].name] = formArr[index].value;
                }
            }
            $.ajax({
                type : 'POST',
                url  : '/inbox/saveMessage',
                data :  obj,
                dataType : 'json',
                success  : function(data) {
                    $('#viewMessage .modal-footer #message_reply_form #message').val('');
                    $("#viewMessage").modal('hide');
                    swal('Message send successfully');
                }
            });
        }
    });

    function getUserUnreadMessageCount() {
        $.ajax({
            type : 'POST',
            url  : '/getUserUnreadMessageCount',
            data : { },
            dataType : 'json',
            success  : function(data) {
                if(data.status == 'success')
                    $('.un-icob').html(data.totalInboxUnreadMessageCount);
            }
        });
    }

        //Number.prototype.format = function(n) {
          //  return n.toFixed(2).replace(/(\d)(?=(\d{3})+\.)/g, '$1,');
        //};
       
    function formatMoney(number) {
        var numbers = number.toString().replace(/,/g, '');
        numbers = Number(parseFloat(numbers).toFixed(2)).toLocaleString();
        if(!numbers.includes('.')) {
            numbers = numbers+'.00';
        }
        return numbers;
    }
</script>

<script type="text/javascript" src="{$config.url}/js/jquery.datetimepicker.js"></script>
<script type="text/javascript" src="{$config.url}/js/zooms.js"></script>
{foreach $external2js as $key => $val}
    <script src="{$config['externaljs']}{$val}.js" type="text/javascript"></script>
{/foreach}