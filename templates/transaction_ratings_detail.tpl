 {include file="common/header-1.tpl" nocache}
<link rel="stylesheet" href="{$config['externalcss']}jquery.datetimepicker.css" type="text/css" />
<style media="screen">
.loader_div .loader {
    height: 63px;
    margin-top: 20%;
    margin-left: 47%;
}

.loader_div {
    background: rgb(0, 0, 0);
    background: transparent;
    background: rgba(0, 0, 0, 0.5);
    /* FF3+,Saf3+,Opera 10.10+,Chrome,IE9*/
    filter: progid:DXImageTransform.Microsoft.gradient(startColorstr=#7f000000, endColorstr=#7f000000);
    /*IE 5.5-7*/
    -ms-filter: "progid:DXImageTransform.Microsoft.gradient(startColorstr=#7f000000,endColorstr=#7f000000)";
    /*IE8*/
    zoom: 1;
    width: 100%;
    height: 100%;
    z-index: 104;
    position: fixed;
    display: block;
    top: 0;
    left: 0;
}

.category-heading img {
    display: inline-block;
    margin-right: 6px;
}

.activecat {
    font-weight: bold;
}

.tqtytext {
    color: red;
}
</style>
<!--  <div class="loader_div">
     <img src="{$config.url}/images/ajaxloader.gif" alt="" class='loader'>
 </div> -->
{include file="store/css-store.tpl" nocache}
<style>
.img-info {
    left: 0;
    position: absolute;
    top: 10%;
}

.bck-img {
    height: auto;
    width: 100%;
}

.carousel-control.right {
    background-image: none;
    top: 165px;
    right: -100px;
}

.carousel-control.left {
    background-image: none;
    top: 165px;
    left: -95px;
    ;
}

.gry_but span {
    background: rgba(0, 0, 0, 0) url("/images/home/textbutton.png") no-repeat scroll 0 -96px;
    color: #5d5f62;
    display: block;
    font-family: Arial, Helvetica, sans-serif !important;
    font-size: 11px !important;
    font-weight: bold;
    margin-right: 7px;
    padding: 8px 3px 9px 10px;
    text-align: center;
}

#fac_id {
    float: left;
    margin-top: 0;
    display: none;
}

#twi_id {
    float: left;
    margin-top: 0;
    display: none;
}

#goo_id {
    float: left;
    margin-top: 0;
    display: none;
}

#web_id {
    display: none;
    float: left;
    margin-top: 0;
}

.dropup {
    float: right;
}

.store-head .bt-info .btn-group .btn:focus {
    box-shadow: inset 0 3px 5px rgba(0, 0, 0, .125);
    border: 2px solid #ccc;
    background: #f9f8f8;
}

.store-head .bt-info .btn-group .btn.active:focus {
    background: #e5e5e5;
    box-shadow: inset 0 3px 5px rgba(0, 0, 0, .125);
    border: 2px solid rgba(85, 85, 85, 0.55);
}

.right {
    margin: 10px 0;
    float: right;
    cursor: pointer;
    display: inline-block;
}
</style>
<div class="container-fluid grey-bg xs-pdlr">
    <div class="container dashboard-settings-con m50">
        <div class="row">
            
            <div class="col-md-8 col-md-offset-2 content-area">
                <div class="row">
                        <a class="btn btn-success" href="{$config.url}/profile_settings/transaction_ratings">
                            Back
                        </a>
                        <br><br>
                    <div class=" white-bg-2 shadow">
                        <div class="table-responsive">
                            <table class="table table-bordered1 table-hover">
                                <tbody>
                                    {if $rating_data.rating_type == 'buyer'}
                                    <tr>
                                        <td>
                                            <b>Product Purchased: </b>{$rating_data.product_name}
                                        </td>
                                        <td>
                                            <b>Delivery Date: </b>{$rating_data.delivered_at}
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            Buyer Space
                                        </td>
                                        <td>
                                            <span class="stars">{$rating_data.delivery}</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            Buyer Personnel Prepared
                                        </td>
                                        <td>
                                            <span class="stars">{$rating_data.deliveryinfo}</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            Buyer Inspection  
                                        </td>
                                        <td>
                                            <span class="stars">{$rating_data.prodinspect}</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            Buyer Paperwork 
                                        </td>
                                        <td>
                                            <span class="stars">{$rating_data.delreceipt}</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            Buyer Personnel Professionalism  
                                        </td>
                                        <td>
                                            <span class="stars">{$rating_data.personnel}</span>
                                        </td>
                                    </tr>
                                    <tr><td style="padding: 0px;"></td><td style="padding: 0px;"></td></tr>
                                    <tr><td style="padding: 0px;"></td><td style="padding: 0px;"></td></tr>
                                    <tr>
                                        <td>
                                            <b>Average Performance Rating </b>
                                        </td>
                                        <td>
                                            <span class="stars">{$rating_data.avg_rating}</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            Buyer Payment  
                                        </td>
                                        <td>
                                            <span class="stars">{$rating_data.tpayment}</span>
                                        </td>
                                    </tr>
                                    <tr><td style="padding: 0px;"></td><td style="padding: 0px;"></td></tr>
                                    <tr><td style="padding: 0px;"></td><td style="padding: 0px;"></td></tr>
                                    <tr>
                                        <td>
                                            <b>Overall Buyer Rating </b>
                                        </td>
                                        <td>
                                            <span class="stars">{($rating_data.avg_rating+$rating_data.tpayment)/2}</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">
                                            <b>Review:</b> {$rating_data.comment}
                                        </td>
                                    </tr>
                                {/if}


                                {if $rating_data.rating_type == 'seller'}
                                    <tr>
                                        <td>
                                            <b>Product Sold: </b>{$rating_data.product_name}
                                        </td>
                                        <td>
                                            <b>Delivery Date: </b>{$rating_data.delivered_at}
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            Seller Product Accuracy 
                                        </td>
                                        <td>
                                            <span class="stars">{$rating_data.accurate}</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            Seller Timely Delivery
                                        </td>
                                        <td>
                                            <span class="stars">{$rating_data.delivery}</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            Seller Compliant Packaging  
                                        </td>
                                        <td>
                                            <span class="stars">{$rating_data.packing}</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            Seller Customer Service  
                                        </td>
                                        <td>
                                            <span class="stars">{$rating_data.customer_support}</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            Buyer Satisfaction   
                                        </td>
                                        <td>
                                            <span class="stars">{$rating_data.satisfaction}</span>
                                        </td>
                                    </tr>
                                    <tr><td style="padding: 0px;"></td><td style="padding: 0px;"></td></tr>
                                    <tr><td style="padding: 0px;"></td><td style="padding: 0px;"></td></tr>
                                    <tr>
                                        <td>
                                            <b>Average Performance Rating</b>
                                        </td>
                                        <td>
                                            <span class="stars">{$rating_data.avg_rating}</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">
                                            <b>Review:</b> {$rating_data.comment}
                                        </td>
                                    </tr>
                                {/if}
                                </tbody>
                            </table>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </div>
</div>
{include file="common/footer-1.tpl" nocache}
</body>

</html>
<script type="text/javascript" src="{$config.url}/js/jquery.datetimepicker.js"></script>
<script src="{$config.url}/js/mtree.js"></script>
<script src="{$config.url}/js/jcrop.js"></script>
<link rel="stylesheet" type="text/css" href="{$config['externalcss']}/jcrop.css" />
<script type="text/javascript" src="{$config.url}/js/owl.carousel.js"></script>
<!-- <script src="https://auctionsoftwaremarketplace.com:2002/js/owl.carousel.js"></script> -->